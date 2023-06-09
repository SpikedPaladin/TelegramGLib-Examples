using Telegram;

void main() {
    // Create our bot
    var bot = new EchoBot();
    
    // Start bot to make them recieve updates
    bot.start();
}

public class EchoBot : Bot {
    
    construct {
        // Token from variable:
        // token = Environment.get_variable("TOKEN");
        
        // Input token from @BotFather here
        token = "YOUR TOKEN HERE";
        
        // To enable debug prints uncomment next line
        // config.debug = true;
    }
    
    public override void on_update(Update update) {
        
        // Check if recieved update has message & if message has text
        if (update.message != null && update.message.text != null) {
            
            // Creating request to send message
            var msg = new SendMessage();
            
            // Specifying chat_id to send to
            msg.chat_id = update.message.chat.id;
            // Reply to user message
            msg.reply_to_message_id = update.message.message_id;
            // Specify text of our message
            msg.text = @"Your message: $(update.message.text)";
            
            // Send message to user
            send.begin(msg);
        }
    }
}
