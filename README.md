# Conekta

Swift wrapper to connect with https://api.conekta.io.

```swift
let conekta = Conekta(publicKey: "key_DSUNVu8YgECm6ZyskQoFDoQ")!

let card = Card(number: "4111111111111111", name: "test", cvc: "111", month: "11", year: "2020")
conekta.collectDevice(view: controller.view)
conekta.getToken(for: card) { (token, error) in
    if let error = error {
       print(error)
    } else if let token = token {
       print(token)
    }
}
```
