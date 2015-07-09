
//com gambiarras absurdas, não leia... fora mais de 3h de tentativa a ideia *brilhante*

//trabalho 13

import java.util.concurrent.locks.ReentrantLock;
public class trabalho13{
	static Ficha f = new Ficha(0);
	static int numThreads = 8;
	static int contador = 0;

	public static void main(String[] args){
		Thread[] t = new Util[numThreads];

		do{
			for (int i = 0; i < numThreads; i++) {
				t[i] = new Util(i);
				t[i].start();
			}

			for (int i = 0; i < numThreads; i++) {
				try{
					t[i].join();	
				} catch(Exception e){}
				
			}
			contador++;
		} while(contador < 10000);
	}

	static class Util extends Thread{
		int threadId;
		int fichaPorThread = 10;
		int numFicha, fichaMin;
		String name;

		public Util(int n){
			threadId = n;
			name = "t" + threadId;
		}
		 

		public void run(){

			synchronized(f){
				f.getFicha();
				System.out.println("Thread " + threadId + " Turn " + turn + " Ficha " + f.ficha);
			}	
		}
	}
}



class Ficha{
	int ficha;
	ReentrantLock locker;

	public Ficha(int i){
		ficha = i;
		locker = new ReentrantLock();
	}

	public int getFicha(){
		return ficha++;
	}

	public void goOn(){
		//turn++;
		//action.unlock();
	}
}

/*
*
* 2. 
*	Safety é 
*	Liveness é o oposto do deadlock, ao invés de segurar o recurso existe uma facilidade de soltar 
*	o recurso para que outra thread o use, porém num cenário que se prolonga temporalmente termina 
*	que nenhum trabalho é realmente feito. (Filósofos educados)
*	
*	Problema das fichas
*		
*		
*/
