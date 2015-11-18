package threadPool;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class ThreadPoolExecutorTest {

	public static void main(String[] args) {

		// ����һ���ɻ����̳߳أ�����̳߳س��ȳ���������Ҫ���������տ����̣߳����޿ɻ��գ����½��̡߳�
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

		// /����һ�������̳߳أ��ɿ����߳���󲢷������������̻߳��ڶ����еȴ���
		// ��Ϊ�̳߳ش�СΪ3��ÿ���������index��sleep 2�룬����ÿ�����ӡ3�����֡�
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

		// ����һ�������̳߳أ�֧�ֶ�ʱ������������ִ�С��ӳ�ִ�� , ��ʾ�ӳ�1���ÿ3��ִ��һ�Ρ�
		// ScheduledExecutorService scheduledThreadPool =
		// Executors.newScheduledThreadPool(5);
		// System.out.println("begin:");
		// scheduledThreadPool.schedule(new Runnable() {
		// public void run() {
		// System.out.println("delay 3 seconds");
		// }
		// }, 3, TimeUnit.SECONDS);

		// ����һ�����̻߳����̳߳أ���ֻ����Ψһ�Ĺ����߳���ִ�����񣬱�֤����������ָ��˳��(FIFO, LIFO, ���ȼ�)ִ�С�
		// �������������൱��˳��ִ�и�������
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
