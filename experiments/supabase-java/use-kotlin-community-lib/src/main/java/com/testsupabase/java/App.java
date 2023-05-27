package com.testsupabase.java;

import io.github.jan.supabase.SupabaseClient;
import io.github.jan.supabase.SupabaseClientBuilder;
import io.github.jan.supabase.gotrue.GoTrueConfig;
import io.github.jan.supabase.gotrue.GoTrueImpl;

public class App {
    public static void main(String[] args) {
        final String url = "https://<ourkey>.supabase.co";
        final String anonKey =
                "insert";
        SupabaseClientBuilder builder = new SupabaseClientBuilder(url, anonKey);
        SupabaseClient client = builder.build();

        java.lang.reflect.Method[] methods = client.getClass().getMethods();
        for (int i = 0; i < methods.length; i++) {
            System.out.println(methods[i].toString());
        }

        GoTrueConfig goTrueConfig = new GoTrueConfig();
        GoTrueImpl goTrue = new GoTrueImpl(client, goTrueConfig);

        goTrue.reauthenticate();
    }
}
