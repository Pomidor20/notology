#!/usr/bin/env python
# coding=utf-8
import pika

# Указываем параметры подключения к RabbitMQ на другом хосте
credentials = pika.PlainCredentials('admin', 'password')
parameters = pika.ConnectionParameters('192.168.99.186', 5672, '/', credentials)
connection = pika.BlockingConnection(parameters)

channel = connection.channel()
channel.queue_declare(queue='hello')


def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)


channel.basic_consume(on_message_callback=callback, queue='hello', auto_ack=False)
channel.start_consuming()

