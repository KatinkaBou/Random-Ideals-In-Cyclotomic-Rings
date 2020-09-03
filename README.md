This repository contains a Sage code to compute the probability that k many random ideals in a cyclotomic number ring are relatively prime.
The computations follow the approach of Sittinger and DeMoss [1].

In order to use the code within the virtual sage machine, simply download the file RandomIdeals.sage.

Example:

..: load("RandomIdeals.sage")
..: prob_pairwise_prime(5,2)

<<  The probability that 2 elements in the 5-th cyclotomic ring are pairwise relatively prime is approximately 0.915462703726131.

[1] https://arxiv.org/abs/1803.09187
