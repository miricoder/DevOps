#!/usr/bin/env python3
# Written by Mirali Mirzayev on Feb 26 2022 to control AWS ec2 Start and Stop operations

import boto.ec2
import sys 


#Specify AWS key
auth = {"aws_access_key_id" : "<>", "aws_secret_access_key": "<>"}
instance_ids="instance_ids"
class AwsInstances:
	def main(self, instance_ids):
		# read arguments from the command line and 
		# check whether at least two elements are entered 
		self.instance_ids = instance_ids
		if len(sys.argv) < 2:
			print("Usage: pyhton aws.py {start|stop}\n")
			sys.exit(0)
		else:
			action = sys.argv[1]	

		if action == "start" and action == instance_ids:
			startInstance()
		elif action == "stop" and action == instance_ids:
			stopInstance()
		else:
			print("Usage: python aws.py {start|stop}\n")	

	def startInstance():
		print("Starting the instance...")

		# change "us-east-1" refion if different
		try:
			ec2 = boto.ec2.connect_to_region("us-east-1", **auth)

		except Exception as e1:
				error1 = "Error1: %s" % str(e1)
				print(error1)
				sys.exit(0)

		# change instance ID appropriately
		try:
			# ibp-resume ---> i-0619b57b294d5065a
			ec2.start_instances(instance_ids=self.instance_ids) 		 
		
		except Exception as e2:
			error2 = "Error2: %s" % str(e1)
			print(error2)
			sys.exit(0)

	def stopInstance(self):
		print("Stopping the instance...")		

		try:
			ec2 = boto.ec2.connect_to_region("us-east-1", **auth)

		except Exception as e1:
			error1 = "Error1: %s" % str(e1)	
			print(error1)
			sys.exit(0)
		try:
			ec2.stop_instances(instance_ids=self.instance_ids)	

		except Exception as e2:
			error2 = "Error2: %s" % str(e2)	
			print(error2)	
			sys.exit(0)
		
if __name__ == '__main__':
	main()	







