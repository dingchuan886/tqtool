package com.test;

public class TestWhile extends Thread {

	@Override
	public void run() {

		while (true) {
			for (int i = 0; i < 20; i++) {
				try {
					System.out.println("TestWhile.run()");
					Thread.sleep(1);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				System.out.println("----end----");
			}
		}

	}

	public static void main(String[] args) {
		new TestWhile().start();

	}

}
