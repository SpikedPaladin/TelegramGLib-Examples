using Telegram.Requests;
using Telegram.Types;
using Telegram;

void main() {
    // Create our bot
    var bot = new InlineBot();
    
    // Start bot to make them recieve updates
    bot.start();
    
    // Creating a main loop for our bot to run until the application is closed
    new MainLoop().run();
}

public class InlineBot : Bot {
    // Some example settings
    private bool answer_empty_query = true;
    private bool answer_pm = true;
    
    construct {
        // Token from variable:
        // token = Environment.get_variable("TOKEN");
        
        // Input token from @BotFather here
        token = "YOUR TOKEN HERE";
        
        // To enable debug prints uncomment next line
        debug = true;
    }
    
    public override void update_recieved(Update update) {
        
        // Check if recieved update has inline query
        if (update.inline_query != null) {
            
            // Create request
            var request = new AnswerInlineQuery();
            
            // Set the ID to which we will respond
            request.inline_query_id = update.inline_query.id;
            
            // Create array of our inline results
            InlineQueryResult[] results = {};
            
            // Check if user query not empty
            if (update.inline_query.query != "") {
                
                // Add image result if user prompted 'image'
                if (update.inline_query.query == "image") {
                    
                    results += new InlineQueryResultPhoto() {
                        // Generate random id for our result
                        id = Uuid.string_random(),
                        
                        // Set photo for result
                        photo_url = "https://i.ibb.co/jDsgKx5/Vala.png",
                        // Set thumbnail for result
                        thumbnail_url = "https://i.ibb.co/jDsgKx5/Vala.png"
                    };
                
                // Add user query as result
                } else {
                    results += new InlineQueryResultArticle() {
                        // Generate random id for our result
                        id = Uuid.string_random(),
                        
                        // Set title for our result
                        title = "Print your message",
                        // Set description for our result
                        description = update.inline_query.query,
                        // Set message which will be sent to chat
                        input_message_content = new InputTextMessageContent() {
                            message_text = update.inline_query.query,
                        }
                    };
                }
            
            // Add special result if query is empty
            } else if (answer_empty_query) {
                results += new InlineQueryResultArticle() {
                    id = Uuid.string_random(),
                    title = "Print best language in the world",
                    thumbnail_url = "https://i.ibb.co/jDsgKx5/Untitled1.png",
                    input_message_content = new InputTextMessageContent() {
                        message_text = "<a href=\"https://en.wikipedia.org/wiki/Vala_(programming_language)\">Vala</a> <b>- best language</b>",
                        parse_mode = ParseMode.HTML,
                        disable_web_page_preview = true
                    }
                };
            }
            
            // Put our results to request
            request.results = results;
            
            // Send our request
            send.begin(request);
            
            // Send ping message if user send any message to our bot
        } else if (answer_pm && update.message != null && update.message.chat.type == Chat.Type.PRIVATE) {
            var request = new SendMessage();
            request.text = "Ping!";
            request.chat_id = update.message.chat.id;
            request.reply_to_message_id = update.message.message_id;
            
            send.begin(request);
        }
    }
}
