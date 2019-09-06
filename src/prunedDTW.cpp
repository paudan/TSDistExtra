/*****************************************************************************/
/* Code by Diego Furtado Silva
/*
/* This code has been adapted from the code provided with the following paper:
/*
/* Rakthanmanon, Thanawin, et al. "Searching and mining trillions of time 
/*	series subsequences under dynamic time warping." Proceedings of the 18th 
/*	SIGKDD international conference on Knowledge discovery and data mining.
/*	ACM. 2012.
/*
/* If you are interested in reuse this code, we suggest to check the original
/* 	licensing at http://www.cs.ucr.edu/~eamonn/UCRsuite.html
/*****************************************************************************/

#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <ctime>
#include <fstream>
#include <vector>

#define min(x,y) ((x)<(y)?(x):(y))
#define max(x,y) ((x)>(y)?(x):(y))
#define dist(x,y) ((x-y)*(x-y))

#define INF 1e20       //Pseudo Infitinte number for this code

using namespace std;

bool readFiles(char *fileToRead, vector< vector<double> > &data) {
	
	char* auxLine;
	double auxVal;
	vector<double> auxTS;
	std::ifstream fin (fileToRead);
	std::string line;
	int offset;
	
	if (fin.is_open()) {
		
		while ( getline(fin, line, '\n') ) {
			
			int i = 0;
			
			line += ",";
			auxLine = (char *)line.c_str();			
			auxTS.clear();
			
			while(sscanf(auxLine, " %lf,%n", &auxVal, &offset) == 1) {

				if (i != 0)
					auxTS.push_back(auxVal);

				auxLine += offset;
				i++;
				
			}

			data.push_back(auxTS);
			
		}
		
	} else {

		return false;

	}
	
	return true;
	
}

double pruneddtw(vector<double> A, vector<double> B, double w) {

    double *cost;
    double *cost_prev;
    double *cost_tmp;
    int i,j,k;
    double x,y,z;
	
	int m = A.size();
	int r = floor(m*w);

    // Variables to implement the pruning - PrunedDTW
	int sc = 0, ec = 0, next_ec, lp; //lp stands for last pruning
	double UB = 0;
	bool foundSC, prunedEC;
	int iniJ;

    /// Instead of using matrix of size O(m^2) or O(mr), we will reuse two array of size O(m).
	cost = (double*)malloc(sizeof(double)*(m));
	cost_prev = (double*)malloc(sizeof(double)*(m));
	
	double *ub_partials;
	ub_partials = (double*)malloc(sizeof(double)*(m));

    for(j=0; j<m; j++) {	
	
		cost[j]=INF;
		cost_prev[j]=INF;
		
		if (j==0)
			ub_partials[m-j-1] = dist(A[m-j-1],B[m-j-1]);
		else
			ub_partials[m-j-1] = ub_partials[m-j] + dist(A[m-j-1],B[m-j-1]);
		
	}
	UB = ub_partials[0];

    for (i=0; i<m; i++)
    {

		foundSC = false;
		prunedEC = false;
		next_ec = i+r+1;
		
		iniJ = max(0,max(i-r, sc));		

        for(j=iniJ; j<=min(m-1,i+r); j++)
        {
            /// Initialize all row and column
            if ((i==0)&&(j==0))
            {
				cost[j]=dist(A[0],B[0]);
				foundSC = true;
                continue;
            }

            if (j==iniJ)                         y = INF;
            else                                 y = cost[j-1];
            if ((i==0)||(j==i+r)||(j>=lp))       x = INF;
            else                                 x = cost_prev[j];
            if ((i==0)||(j==0)||(j>lp))          z = INF;
            else                                 z = cost_prev[j-1];

            /// Classic DTW calculation
            cost[j] = min( min( x, y) , z) + dist(A[i],B[j]);
			
			/// Pruning criteria
			if (!foundSC && cost[j] <= UB) {
				sc = j;
				foundSC = true;
			}
			
			if (cost[j] > UB) {				
				if (j > ec) {
					lp = j;
					prunedEC = true;
					break;
				}				
			} else {
				next_ec = j+1;
			}

        }
		UB = ub_partials[i+1]+cost[i];
	
        /// Move current array to previous array.
        cost_tmp = cost;
        cost = cost_prev;
        cost_prev = cost_tmp;
		
		/// Pruning statistics update
		if(sc > 0)
			cost_prev[sc-1] = INF;
		
		if (!prunedEC)
			lp = i+r+1;
		
		ec = next_ec;
		
    }
	
    /// the DTW distance is in the last cell in the matrix of size O(m^2) or at the middle of our array.
    double final_dtw = cost_prev[m-1];
    free(cost);
    free(cost_prev);
    return final_dtw;
	
}

int main(int argc, char* argv[]) {
	
	clock_t t1, t2;
	vector< vector<double> > data;
	double window;
	
	if (argc < 2) {
		printf("Parameters error\nCorrect using is:\n");
		printf("./pruendDTW dataset warping_window (warping is optional - [0,1])\n\n");
		return 1;
	}

	if (argc < 3) {
		printf("Warning: warping window percentage (third arg) will be defined as 1.\n\n");
		window = 1;
	} else {

		window = atof(argv[2]);

		if (window < 0 || window > 1) {
			printf("Parameters error\nCorrect using is:\n");
			printf("./pruendDTW dataset warping_window (warping is optional - [0,1])\n\n");
			return 1;
		}

	}

	printf("Reading files (we consider the values in the first column as class label)\n");
	
	if (!readFiles(argv[1], data)) {
		
		printf("Error opening file.\n\n");
		return 0;
		
	}
	
	printf("Read data is compose of %d examples with %d observations each\n\n", data.size(), data[1].size());
	
	
	t1 = clock();
	
	for (int i = 0; i < data.size(); i++)
		for (int j = i + 1; j < data.size(); j++)
			printf("%.2lf ", pruneddtw(data[i],data[j],window));
	
	
	t2 = clock();
	
	printf("Total time: %lf\n\n", (double)(t2-t1)/CLOCKS_PER_SEC);
	
}