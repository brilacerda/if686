package if686;

public class Exer1 {
	
	public static void main(String[] args) {	
		long ini =  System.currentTimeMillis();
		Thread[] t = new Imprimir[10];
		long limit = 2000000000;
		long size = limit/10;

		for(int i = 0; i < 10; i++){
			t[i] = new Imprimir(size*i, size*(i+1));
			t[i].start();		
		}	
		
		for(int i = 0; i < 10; i++){
			try {
				t[i].join();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		long fim = System.currentTimeMillis();
		double d = (fim-ini);
		System.out.println("Tempo de execução sem o print de cada elemento: " + d +" ms\n");
	}	
}

class Imprimir extends Thread{
	long fst, lst;

	public Imprimir(long ini, long fim) {
		fst = ini;
		lst = fim;
	}

	public void run (){
		System.out.println("limite inferior: " + fst + " limite superior: " + lst);
		while(fst <= lst){
			
			fst++;
		}
	}
}

/*
caso eu queira imprimir todos os elementos na tela existirá uma  
competição pela mesma, o que causa um tempo longo na execução das 
threads

limite inferior: 0 limite superior: 200000000
limite inferior: 400000000 limite superior: 600000000
limite inferior: 200000000 limite superior: 400000000
limite inferior: 600000000 limite superior: 800000000
limite inferior: 1000000000 limite superior: 1200000000
limite inferior: 1400000000 limite superior: 1600000000
limite inferior: 1600000000 limite superior: 1800000000
limite inferior: 800000000 limite superior: 1000000000
limite inferior: 1200000000 limite superior: 1400000000
limite inferior: 1800000000 limite superior: 2000000000*/
