using System.Text.Json;

namespace QLKhachSan.Helpers
{
    public static class SessionExtensions
    {
        public static void Set<T>(this ISession session, string key, T value)
        {
            session.SetString(key, JsonSerializer.Serialize(value));
        }

        public static T? Get<T>(this ISession session, string key)
        {
            var value = session.GetString(key);
            return value == null ? default : JsonSerializer.Deserialize<T>(value);
        }
        public static void SetBool(this ISession session, string key, bool value)
        {
            session.SetString(key, value ? "true" : "false");
        }

        public static bool? GetBool(this ISession session, string key)
        {
            var value = session.GetString(key);
            return value == null ? (bool?)null : value == "true";
        }
    }
}
