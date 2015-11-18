package threadPool;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class ThreadPoolExecutorTest {

	public static void main(String[] args) {

		// 创建一个可缓存线程池，如果线程池长度超过处理需要，可灵活回收空闲线程，若无可回收，则新建线程。
		// ExecutorService cachedThreadPool = Executors.newCachedThreadPool();
		//
		// for (int i = 0; i < 100; i++) {
		// final int index = i;
		//
		// // try {
		// // Thread.sleep(index * 1000);
		// // } catch (InterruptedException e) {
		// // e.printStackTrace();
		// // }
		//
		// cachedThreadPool.execute(new Runnable() {
		// public void run() {
		// try {
		// Thread.sleep(5 * 1000);
		// } catch (InterruptedException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }
		// System.out.println(index+"------------"+Thread.currentThread().getName());
		// }
		// });
		//
		// }

		// /创建一个定长线程池，可控制线程最大并发数，超出的线程会在队列中等待。
		// 因为线程池大小为3，每个任务输出index后sleep 2秒，所以每两秒打印3个数字。
		// ExecutorService fixedThreadPool = Executors.newFixedThreadPool(3);
		// for (int i = 0; i < 10; i++) {
		// final int index = i;
		// fixedThreadPool.execute(new Runnable() {
		// public void run() {
		// try {
		// System.out.println(index);
		// Thread.sleep(2000);
		// } catch (InterruptedException e) {
		// e.printStackTrace();
		// }
		// }
		// });
		// }

		// 创建一个定长线程池，支持定时及周期性任务执行。延迟执行 , 表示延迟1秒后每3秒执行一次。
		// ScheduledExecutorService scheduledThreadPool =
		// Executors.newScheduledThreadPool(5);
		// System.out.println("begin:");
		// scheduledThreadPool.schedule(new Runnable() {
		// public void run() {
		// System.out.println("delay 3 seconds");
		// }
		// }, 3, TimeUnit.SECONDS);

		// 创建一个单线程化的线程池，它只会用唯一的工作线程来执行任务，保证所有任务按照指定顺序(FIFO, LIFO, 优先级)执行。
		// 结果依次输出，相当于顺序执行各个任务。
		// ExecutorService singleThreadExecutor =
		// Executors.newSingleThreadExecutor();
		// for (int i = 0; i < 10; i++) {
		// final int index = i;
		// singleThreadExecutor.execute(new Runnable() {
		// public void run() {
		// try {
		// System.out.println(index);
		// Thread.sleep(2000);
		// } catch (InterruptedException e) {
		// e.printStackTrace();
		// }
		// }
		// });
		// }

		ExecutorService singleThreadExecutor = Executors.newCachedThreadPool();
		for (int i = 0; i < 100; i++) {
			final int index = i;
			singleThreadExecutor.execute(new Runnable() {
				public void run() {
					try {
						while (true) {
							System.out.println(index);
							Thread.sleep(10 * 1000);
						}
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			});
			
			
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			
			
		}

	}

}
