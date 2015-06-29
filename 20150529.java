package if686;

public class Trabalho12 {
	//dado uma matriz A 3x4 e outra B 4x2 e duas threads
	static int x = 3, y = 4, z = 2;
	static int A[][] = new int [x][y];
	static int B[][] = new int[y][z];
	static int Res[][] = new int [x][z];
	static int nThreads = x;
	static Thread[] t = new Multiplica[nThreads];

	public static void main(String[] args) {
		int mult [][] = new int [x][z];

		//cria A com todas as posições 1
		for (int i = 0; i < x; i++) {
			for (int j = 0; j < y; j++) {
				A[i][j] = 1; 
			}
		}
		
		//cria B com todas as posições 2
		for (int i = 0; i < y; i++) {
			for (int j = 0; j < z; j++) {
				B[i][j] = 3; 
			}
		}

		//inicializando as threads
		for (int i = 0; i < nThreads; i++) {
			t[i] = new Multiplica(i); //passa pro construtor a linha que vai ser trabalhada em A
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
		
		//printando o resultado
		for (int i = 0; i < x; i++) {
			for (int j = 0; j < z; j++) {
				System.out.print(Res[i][j] + " ");
			}
			System.out.println();
		}
	}
	public static class Multiplica extends Thread{
		int n;

		public Multiplica(int linhaEmA){ //linha que a thread vai trabalhar em A
			n = linhaEmA; 
		}

		public void run(){
			
			for (int i = 0; i < z; i++) { //itera nas z colunas que a matriz B tiver
				Res[n][i] = 0; //setta pra 0 a posição que vai ser somada
				for (int j = 0; j < y; j++) { //itera e soma os elementos da matriz
					Res[n][i] += (A[n][j] * B[j][i]);
				}
			}
			
		}

	}
}
