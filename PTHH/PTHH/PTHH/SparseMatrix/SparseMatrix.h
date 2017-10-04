/**
 * This file is part of the SparseMatrix library
 *
 * Copyright (c) 2014 Petr Kessler (http://kesspess.1991.cz)
 *
 * @license  MIT
 * @link     https://github.com/uestla/Sparse-Matrix
 */

#ifndef __SPARSEMATRIX_H__

	#define	__SPARSEMATRIX_H__

	#include <vector>
	#include <iostream>

	using namespace std;

	template <typename T>
	class SparseMatrix
	{

		public:

			/**
			 * Creates a square matrix
			 *
			 * @param  n number of rows and columns
			 */
			SparseMatrix(int n);

			~SparseMatrix(void);


			/**
			 * Creates a non-square matrix
			 *
			 * @param  rows number of rows
			 * @param  columns number of columns
			 */
			SparseMatrix(int rows, int columns);


			/**
			 * Element value getter
			 *
			 * @param  row
			 * @param  col
			 * @return value of element or 0 if value has not been set yet
			 */
			T get(int row, int col) const;


			/**
			 * Element value setter
			 *
			 * @param  value
			 * @param  row
			 * @param  col
			 * @return self for fluent interface
			 */
			SparseMatrix & set(T val, int row, int col);


			/**
			 * Multiplies matrix with vector
			 *
			 * @param  x vector
			 * @return result of the product
			 */
			vector<T> multiply(const vector<T> & x) const;


			/**
			 * Multiplies matrix by another matrix
			 *
			 * @param  m
			 * @return result of the product
			 */
			SparseMatrix multiply(const SparseMatrix & m) const;


			/**
			 * Adds another matrix to this matrix
			 *
			 * @param  m
			 * @return result of the sum
			 */
			SparseMatrix add(const SparseMatrix & m) const;
        
            void dispList();


			/**
			 * Compares two matrices
			 *
			 * @param  a
			 * @param  b
			 * @return are both matrices equal?
			 */
			template<typename X>
			friend bool operator == (const SparseMatrix<X> & a, const SparseMatrix<X> & b);


			/**
			 * Compares two matrices
			 *
			 * @param  a
			 * @param  b
			 * @return are both matrices unequal?
			 */
			template<typename X>
			friend bool operator != (const SparseMatrix<X> & a, const SparseMatrix<X> & b);


			/**
			 * Prints the internal matrix vectors
			 *
			 * @param  output stream
			 * @param  matrix to print
			 * @return output stream for fluent interface
			 */
			template<typename X>
			friend ostream & operator << (ostream & os, const SparseMatrix<X> & matrix);


			/**
			 * Prints matrix in human friendly format
			 *
			 * @param  matrix to print
			 * @param  output stream
			 */
			template<typename X>
			friend void print(const SparseMatrix<X> & matrix, ostream & os);


		protected:

			int m, n;

			vector<int>  * cols, * rows;
			vector<T> * vals;

			/**
			 * Common internal constructor
			 *
			 * @param  m number of rows
			 * @param  n number of columns
			 */
			void construct(int m, int n);


			/**
			 * Element coordination validator
			 *
			 * @param  row
			 * @param  col
			 */
			void validateCoordinations(int row, int col) const;


			/**
			 * Inserts given value into the matrix
			 *
			 * @param  index at which the new element will be placed
			 * @param  row
			 * @param  col
			 * @param  val
			 */
			void insert(int index, int row, int col, T val);


			/**
			 * Removes value from the matrix
			 *
			 * @param  index
			 * @param  row
			 */
			void remove(int index, int row);

	};

#endif
