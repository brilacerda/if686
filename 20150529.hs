class Main {
	static int x = 3, y = 4, z = 2;
	static int A[][] = new int [x][y];
	static int B[][] = new int[y][z];
	static int nThreads = 2;
	static Thread[] t = new Multiplica[nThreads];
	
	public static void main(String[] args) {
		int mult [][] = new int [x][z];
		
		//cria e popula as duas matrizes
		for (int i = 0; i < x; i++) {
			for (int j = 0; j < y; j++) {
				A[i][j] = 1; 
			}
		}
		
		for (int i = 0; i < y; i++) {
			for (int j = 0; j < z; j++) {
				B[i][j] = 1; 
			}
		}
		
		//inicializando as threads
		for (int i = 0; i < nThreads; i++) {
			t[i] = new Multiplica(i);
			t[i].start();
		}
		
		//threads, se esperem
		for (int i = 0; i < nThreads; i++) {
			try {
				t[i].join();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		
		
	}
	public static class Multiplica extends Thread{
	int n;
	
	public Multiplica(int m){
		n = m; 
	}
	
	public void run(){
		int result = 0;
		for (int i = 0; i < y; i++) {
			result += (A[i][n] * B[n][i]);
		}
	}
	
}
}


