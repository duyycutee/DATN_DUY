using Microsoft.AspNetCore.SignalR;

namespace QLKhachSan.SignalRChat
{
    public class ChatHub : Hub
    {
        public async Task SendMessage()
        {
            await Clients.All.SendAsync("ReceiveMessage");
        }
    }
}
