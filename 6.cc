#include<iostream>
#include<vector>

using namespace std;

int findKthSmallest(const vector<int>& A, const vector<int>& B, int k) {
    int m = A.size();
    int n = B.size();
    // make sure A is the shorter list
    if (m > n) return findKthSmallest(B, A, k);
    // base cases
    if (m == 0) return B[k - 1];
    if (k == 1) return min(A[0], B[0]);
    // divide k into two parts
    int i = min(m, k / 2);
    int j = min(n, k / 2);
    if (A[i - 1] < B[j - 1]) {
        return findKthSmallest(vector<int>(A.begin() + i, A.end()), B, k - i);
    } else {
        return findKthSmallest(A, vector<int>(B.begin() + j, B.end()), k - j);
    }
}