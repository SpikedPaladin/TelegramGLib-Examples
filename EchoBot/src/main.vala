using Telegram;

void main() {
    // Create our bot
    var bot = new Bot();
    
    // Token from variable:
    // token = Environment.get_variable("TOKEN");
    
    // Input token from @BotFather here
    bot.token = "YOUR TOKEN HERE";
    
    // To enable debug prints uncomment next line
    // config.debug = true;
    
    // Add handler that handles message
    bot.add_handler(new MessageHandler(null, msg => {
        // Send message to user
        bot.send.begin(new SendMessage() {
            // Specifying chat_id to send to
            chat_id = msg.chat.id,
            // Reply to user message
            reply_to_message_id = msg.message_id,
            // Specify text of our message
            text = @"Your message: $(msg.text)"
        });
    // Check if message is text message
    }, msg => msg.text != null));
    
    // Start bot to make them recieve updates
    bot.start();
}
