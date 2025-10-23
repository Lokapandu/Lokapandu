import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'

console.log("--- FUNCTION BOOTING (TEST VERSION) ---");

serve(async (req) => {
  try {
    console.log("Function invoked (Test Version)");
    const mySecret = Deno.env.get('API_KEY_CHAT_GEMINI');

    if (mySecret) {
      const partialKey = mySecret.substring(0, 4) + "..." + mySecret.substring(mySecret.length - 4);
      return new Response(
        JSON.stringify({ reply: `BERHASIL! Saya menemukan secret. Awalnya: ${partialKey}` }),
        { headers: { 'Content-Type': 'application/json' } },
      )
    } else {
      throw new Error("GAGAL! Secret 'API_KEY_CHAT_GEMINI' tidak ditemukan di environment.");
    }

  } catch (e) {
    console.error("Function Crash:", e.message);
    return new Response(
      JSON.stringify({ error: `Function crash: ${e.message}` }),
      { status: 500, headers: { 'ContentType': 'application/json' } },
    )
  }
})