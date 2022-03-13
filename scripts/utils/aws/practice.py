#!/usr/bin/env python 

class Dog:
	def __init__(self,breed):
		self.breed = breed
sam = Dog(breed='Lab')
frank  = Dog(breed='Huskie')

print(sam.breed)
print(frank.breed)