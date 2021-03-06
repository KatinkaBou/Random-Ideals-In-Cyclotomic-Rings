#!/usr/bin/env sage
# -*- coding: utf-8 -*-
"""
    Created on 08/25/2020
    Last Modification 09/03/2020
    
    @creator: Katharina BOUDGOUST
    
    ###################################
    #   Relative Prime Random Ideals  #
    ###################################
    """
#-- Example in Sage --#
# ..: load("RandomIdeals.sage")
# ..: m,n=5,2
# ..: prob_pairwise_prime(m,n)
# >> The probability that 2 elements in the 5 -th cyclotomic ring are pairwise relatively prime is approximately 0.915462703726131

#-- Example in Terminal --#
# ..: chmod +x RandomIdeals.sage
# ..: ./RandomIdeals.sage 5 2
# >> The probability that 2 elements in the 5 -th cyclotomic ring are pairwise relatively prime is approximately 0.915462703726131

#-- Import --#
from sage.all import *
import sys
#------------#

if len(sys.argv) != 3:
    print("Usage: {:s} <arg1> <arg2>, where : \n\t <arg1> is an integer defining the <arg1>-th cyclotomic number field \n\t <arg2> is an integer specifying how many ideals are looked at.\n".format(sys.argv[0]));
    sys.exit(2);

m = int(sys.argv[1]);
n = int(sys.argv[2]);

# Function to compmute the multiplicative order of l modulo m
def m_order(l,m):
	i=1
	order=1
	while((l^i)%m!=1):
		i += 1
		order=i
	return order

# Function to generate a list of primes of length bound
def gen_primes(bound):
	primes=[]
	tmp=2
	while len(primes)<bound:
		if is_prime(tmp)==True:
			primes.append(tmp)
		tmp += 1
	return primes

# Main Function to compute the probability that two random elements in O_K are relatively coprime 
# m-th cyclotomic number field
def prob_pairwise_prime(m,n):
	# compute the degree of the ring of integers
	d = euler_phi(m)	
	# t=3
	# compute the bound N to have a good enough approximation
	N=ceil((d*((n-1)^2)*(10^3)+(n-3))/2)
	primes=gen_primes(N)

	proba=1
	first_factor=0
	second_factor=0

	for p in primes:
		# compute the largest integer ell such that p^l divides m
		ell=0
		while frac(m/(p**(ell+1)))==0:
			ell	+= 1
		# compute phi(p^ell)
		h = euler_phi(p**ell) 
		# compute the multiplicative order of p modulo m/p^ell
		f=p%(m/(p^ell))
		if f==0:
			order=1
		else:
			order=m_order(f,m/(p^ell))
		# g = number of primes (each of norm p^order) in the factorization of <p>
		g=d/(order*h)
		if (frac(g)!=0):
			print("Error, the order does not divide d.")
		first_factor = (1.0-(1.0/(p**order)))**(n-1)
		second_factor = 1.0 + ((n-1)/(p**order))
		result = (first_factor * second_factor)**g
		proba *= result

	# output result 
	print("The probability that",n,"elements in the",m,"-th cyclotomic ring are pairwise relatively prime is approximately",proba)
	return

prob_pairwise_prime(m,n)

exit;
