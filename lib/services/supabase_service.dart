import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<dynamic>> fetchData() async {
    final response = await supabase
        .from('monitoring')
        .select()
        .order('waktu', ascending: false)
        .limit(10);
    return response;
  }
}
