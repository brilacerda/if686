
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


//Exercicios da aula 14

import java.util.concurrent.locks.*;

public class VetorThreadSafe{
	static int[] vetor = new int [3];
	static Lock locker = new ReentrantLock();

	public int read(int pos){
		return vetor[pos];
	}

	public void write(int pos, int val){
		
		locker.lock();
		
		try{
			vetor[pos] = val;
		} finally{
			locker.unlock();
		}
	}

	public void swap(int pos1, int pos2, VetorThreadSafe vts){
		Boolean l1 = locker.tryLock();
		Boolean l2 = vts.locker.tryLock();
		int aux;

		try{
			while(!(l1 && l2)){
				if(!l1) locker.unlock();
				if(!l2) vts.locker.unlock();
				l1 = locker.tryLock();
				l2 = vts.locker.tryLock();
			}

		aux = vetor[pos1];
		vetor[pos1] = vetor[pos2];
		vetor[pos2] = aux;
		} finally{
			locker.unlock();
			vts.locker.unlock();
		}
	}

	public static void main(String[] args) {
		VetorThreadSafe v = new VetorThreadSafe();
		Thread pr = new Produtor(v);
		Thread cns = new Consumidor(v);

		pr.start();
		cns.start();
	}
}	

class Produtor extends Thread{
	VetorThreadSafe vts;

	public Produtor(VetorThreadSafe v){
		vts = v;
	}

	public void run(){
		for (int i = 0; i < 3; i++) {
			for (int j = 1; j < 5; j++) {
				vts.write(i, j+5);

				System.out.print("write ");
				for(int k = 0; k < 3; k++){
					System.out.print(vts.read(i) + " ");
				}
				System.out.println();
			}		
		}
	}
}

class Consumidor extends Thread{
	VetorThreadSafe vts;

	public Consumidor(VetorThreadSafe v){
		vts = v;
	}

	public void run(){
		for (int i = 0; i < 3; i++) {
			for (int j = 0; j < 3; j++) {
				vts.swap(i, j, vts);
			
				System.out.print("Swap ");
				for(int k = 0; k < 3; k++){
					System.out.print(vts.read(i) + " ");
				}
				System.out.println();
			}		
		}
	}
}