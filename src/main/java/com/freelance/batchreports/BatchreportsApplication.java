package com.freelance.batchreports;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.client.RestTemplate;

import javax.sql.DataSource;

@SpringBootApplication
@ComponentScan(basePackages = {"com.freelance.*"})
public class BatchreportsApplication {
    private static final Logger logger = LoggerFactory.getLogger(BatchreportsApplication.class);
    @Value("${spring.datasource.url}")
    private String dbUrl;
    @Value("${spring.datasource.driver-class-name}")
    private String dbDriverClass;
    @Value("${spring.datasource.username}")
    private String dbUserName;
    @Value("${spring.datasource.password}")
    private String dbPassword;

    public static void main(String[] args) {
        SpringApplication.run(BatchreportsApplication.class, args);
    }

    @Bean
    public RestTemplate getRestTemplate() {
        return new RestTemplate();
    }

    @Bean
    public DataSource dataSource() {
        DataSourceBuilder dataSourceBuilder = DataSourceBuilder.create();
        dataSourceBuilder.username(dbUserName);
        dataSourceBuilder.url(dbUrl);
        dataSourceBuilder.password(dbPassword);
        dataSourceBuilder.driverClassName(dbDriverClass);
        return dataSourceBuilder.build();

    }

}
