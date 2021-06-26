import 'package:gotrue/gotrue.dart';

const String SPLASH_SCREEN = 'SPLASH_SCREEN';
const String SIGNIN_SCREEN = 'SIGNIN_SCREEN';
const String SIGNUP_SCREEN = 'SIGNUP_SCREEN';
const String PASSWORDRECOVER_SCREEN = 'PASSWORDRECOVER_SCREEN';

const PERSIST_SESSION_KEY = 'PERSIST_SESSION_KEY';

const SUPABASE_URL = 'https://dbcbbaiqjhiotqgvxits.supabase.co';
const SUPABASE_ANNON_KEY =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyNDc0MTAyNCwiZXhwIjoxOTQwMzE3MDI0fQ.ZUOgvILUoIoAcOTIfCkApJ19jR3HxZv9SZlswjSv0L4';
final gotrueClient = GoTrueClient(url: '$SUPABASE_URL/auth/v1', headers: {
  'Authorization': 'Bearer $SUPABASE_ANNON_KEY',
  'apikey': SUPABASE_ANNON_KEY,
});
