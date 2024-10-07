//
//  CWSLNats.swift
//  SmiralCamera
//
//  Created by Kentaro Kawai on 2024/09/05.
//

import Foundation
import Nats

class CWSLNats {
  static func send() async {
    do {
      // # Connecting to a NATS Server
      //The first step is establishing a connection to a NATS server. This example demonstrates how to connect to a NATS server using the default settings, which assume the server is running locally on the default port (4222). You can also customize your connection by specifying additional options:

      let nats = NatsClientOptions()
        .url(URL(string: "nats://192.168.128.143:4222")!)
        // 間違いのアドレスを入れてテスト（結果：Natsライブラリがエラー終了）
        //.url(URL(string: "nats://192.168.128.128:4222")!)
        .build()

      nats.on(.connected) { event in
        print("event: connected")
      }

      try await nats.connect()

      // # Publishing Messages
      // Once you've established a connection to a NATS server, the next step is to publish messages. Publishing messages to a subject allows any subscribed clients to receive these messages asynchronously. This example shows how to publish a simple text message to a specific subject.

      //let data = "message text".data(using: .utf8)!
      //try await nats.publish(data, subject: "foo.msg")

      //let message = "{\"text\": \"こんにちは\", \"target_robot\": [\"UE04PA-A07420003\"]}"
      // t: タイムスタンプ
      // id: UUID生成が望ましい

      // "flow_id" : "FLSrKTpwRZ-OG3sl",

      let message = """
        {
          "id" : "requestId",
          "t" : 1602546613,
          "m": "flow",
          "c" : "flow_start",
          "flow_id" : "FLnzr6Ju-KUyCtWL",
          "index" : 0
        }
      """
      print(message)
      guard let payload = message.data(using: .utf8) else {
        print("Failed to encode message to Data")
        return
      }

      // 一時的なリプライトピックを生成
      let replySubject = "temp_reply_topic_\(UUID().uuidString)"

      // リクエストを送信するトピック
      let requestTopic = "flow.cmd"

      // 一時的なリプライトピックにサブスクライブ
      let subscription = try await nats.subscribe(subject: replySubject)

      // リクエストを送信
      try await nats.publish(payload, subject: requestTopic, reply: replySubject)

      // サブジェクトが間違っていると503が返ってくる

      // レスポンスの待機
      for try await message in subscription {
        print (message)
        guard let payload = message.payload else {
          continue
        }
        if let response = String(data: payload, encoding: .utf8) {
          print("Received response: \(response)")
          break // 応答を受け取ったらループを終了
        }
      }

      // サブスクリプションの終了
      try await subscription.unsubscribe()

      // # Subscribing to Subjects
      // After establishing a connection and publishing messages to a NATS server, the next crucial step is subscribing to subjects. Subscriptions enable your client to listen for messages published to specific subjects, facilitating asynchronous communication patterns. This example will guide you through creating a subscription to a subject, allowing your application to process incoming messages as they are received.

      /*
      let subscription = try await nats.subscribe(subject: "foo.>")

      for try await msg in subscription {

        if msg.subject == "foo.done" {
          break
        }

        if let payload = msg.payload {
          print("received \(msg.subject): \(String(data: payload, encoding: .utf8) ?? "")")
        }

        if let headers = msg.headers {
          if let headerValue = headers.get(try! NatsHeaderName("X-Example")) {
            print("  header: X-Example: \(headerValue.description)")
          }
        }
      }
       */
    } catch {
      print("Error occurred: \(error)")
    }
  }
}

