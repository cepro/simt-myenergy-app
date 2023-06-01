package com.example.springsupabase;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

@SpringBootApplication
public class SpringSupabaseApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringSupabaseApplication.class, args);
    }

    @Bean
    ApplicationRunner applicationRunner(JdbcTemplate jdbcTemplate) {
        return args -> {
            var sql = "select * from users";
            jdbcTemplate.query(sql, new UserRowMapper()).forEach(System.out::println);
        };
    }

    record User(String id, String email, String name, Date createdAt) {
    }

    class UserRowMapper implements RowMapper<User> {
        @Override
        public User mapRow(ResultSet rs, int rowNum) throws SQLException {
            return new User(
                    rs.getString("id"),
                    rs.getString("email"),
                    rs.getString("name"),
                    rs.getDate("created_at"));
        }
    }
}
