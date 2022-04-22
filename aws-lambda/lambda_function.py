import json
import boto3


def lambda_handler(event, context):
    s3 = boto3.resource('s3')
    client = boto3.client('s3')
    bucket = s3.Bucket('sftp-transfer-20')
    dest_bucket = s3.Bucket('sftp-transfer-logging')
    for obj in bucket.objects.all():
        key = obj.key
        dest_key = obj.key
        body = obj.get()['Body'].read()
        if len(body) <= 20:
          print (body)
          s3.Object(dest_bucket.name, dest_key).copy_from(CopySource = {'Bucket': obj.bucket_name, 'Key': obj.key})
        else:
            s3.Object(dest_bucket.name, dest_key).copy_from(CopySource = {'Bucket': obj.bucket_name, 'Key': obj.key})
            client.delete_object(Bucket='sftp-transfer-20', Key=key)