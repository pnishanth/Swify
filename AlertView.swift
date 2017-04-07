// 3 button alertview

func alertViewBox(){

let alert = UIAlertController(title: "title", message: "Message", preferredStyle: UIAlertControllerStyle.alert)

// add the actions (buttons)
alert.addAction(UIAlertAction(title: "Tomorrow", style: UIAlertActionStyle.default, handler: nil))
alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.cancel, handler: nil))
alert.addAction(UIAlertAction(title: "cancel", style: UIAlertActionStyle.destructive, handler: nil))

// show the alert
self.present(alert, animated: true, completion: nil)

}
