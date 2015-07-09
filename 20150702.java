import java.util.concurrent.locks.*;

public class SyncChan {
	static Boolean empty = false;	
	static Lock locker = new ReentrantLock();
	static Condition cond = locker.newCondition();

	public void push(){
		locker.lock();
		try{
			while(empty == false){
				try{
					cond.await();
				} catch(Exception e){}
			}
			empty = false;
			cond.signalAll();
		} finally{
			locker.unlock();
		}

	}

	
	public void pop(){
		locker.lock();
		try{
			while(empty == true){
				try{
					cond.await();
				} catch(Exception e){}
			}
			empty = true;
			cond.signalAll();
		} finally{
			locker.unlock();
		}
	}

	public Boolean peek(){
		return empty;
	}

	public static void main(String[] args) {
		SyncChan sc = new SyncChan();
		Thread pr = new Produtor(sc);
		Thread con = new Consumidor(sc);

		
		con.start();
		pr.start();
	}

}

class Produtor extends Thread{
	SyncChan sc;
	Boolean val;

	public Produtor(SyncChan c){
		sc = c;
	}

	public void run(){
		for (int i = 0; i< 10; i++) {
			sc.push();
			System.out.println("(Prod) Na iteracao "+ i + " esta vazio eh " +sc.empty);
		}
			try{
				sleep((int) Math.random()*100);
			} catch(Exception e){}
	}
}

class Consumidor extends Thread{
	SyncChan sc;

	public Consumidor(SyncChan c){
		sc = c;
	}	

	public void run(){
		for (int i = 0; i < 10; i++) {
			sc.pop();
			System.out.println("(Cons) Na iteracao "+ i + " esta vazio eh " +sc.empty);
		}
	}
}

