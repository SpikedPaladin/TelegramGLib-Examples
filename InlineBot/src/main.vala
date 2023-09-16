using Telegram;

// Some example settings
bool answer_empty_query = true;
bool answer_pm = true;

void main() {
    // Create our bot
    var bot = new Bot();
    
    // Token from variable:
    // token = Environment.get_variable("TOKEN");
    
    // Input token from @BotFather here
    bot.token = "YOUR TOKEN HERE";
    
    // To enable debug prints uncomment next line
    // config.debug = true;
    
    // Add handler that responds only if users input is "image"
    bot.add_handler(new InlineQueryHandler("image", query => {
        // Send our request
        bot.send.begin(new AnswerInlineQuery() {
            // Set the ID to which we will respond
            inline_query_id = query.id,
            results = {
                new InlineQueryResultPhoto() {
                    // Set photo for result
                    photo_url = "https://i.ibb.co/jDsgKx5/Vala.png",
                    // Set thumbnail for result
                    thumbnail_url = "https://i.ibb.co/jDsgKx5/Vala.png",
                    // Set caption for result
                    caption = "Vala Logo"
                }
            }
        });
    }));
    
    // Send user query as result
    bot.add_handler(new InlineQueryHandler(null, query => {
        bot.send.begin(new AnswerInlineQuery() {
            inline_query_id = query.id,
            results = {
                new InlineQueryResultArticle() {
                    // Set title for our result
                    title = "Print your message",
                    // Set description for our result
                    description = query.query,
                    // Set message which will be sent to chat
                    input_message_content = new InputTextMessageContent() {
                        message_text = query.query,
                    }
                }
            }
        });
    }, query => query.query != ""));
    
    // Send special result if query is empty
    bot.add_handler(new InlineQueryHandler(null, query => {
        bot.send.begin(new AnswerInlineQuery() {
            inline_query_id = query.id,
            results = {
                new InlineQueryResultArticle() {
                    title = "Print best language in the world",
                    thumbnail_url = "https://i.ibb.co/jDsgKx5/Vala.png",
                    input_message_content = new InputTextMessageContent() {
                        message_text = "<a href=\"https://en.wikipedia.org/wiki/Vala_(programming_language)\">Vala</a> <b>- best language</b>",
                        parse_mode = ParseMode.HTML,
                        disable_web_page_preview = true
                    }
                }
            }
        });
    // Check if feature is enabled
    }, query => answer_empty_query));
    
    // Send ping message if user send any message to our bot
    bot.add_handler(new MessageHandler(null, msg => {
        bot.send.begin(new SendMessage() {
            chat_id = msg.chat.id,
            reply_to_message_id = msg.message_id,
            text = "Ping!"
        });
    // Check if feature enabled and chat is private
    }, msg => answer_pm && msg.chat.type == Chat.Type.PRIVATE));
    
    // Start bot to make them recieve updates
    bot.start();
}
