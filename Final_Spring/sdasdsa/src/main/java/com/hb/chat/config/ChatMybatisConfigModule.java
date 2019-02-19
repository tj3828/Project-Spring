package com.hb.chat.config;

import java.util.Properties;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.transaction.jdbc.JdbcTransactionFactory;
import org.mybatis.guice.MyBatisModule;
import org.mybatis.guice.datasource.builtin.PooledDataSourceProvider;
import org.mybatis.guice.session.SqlSessionManagerProvider;

import com.google.inject.PrivateModule;
import com.google.inject.Scopes;
import com.google.inject.name.Names;
import com.hb.chat.IChatDAOMapper;

import static com.google.inject.name.Names.bindProperties;


public class ChatMybatisConfigModule extends PrivateModule {
    
   @Override
   protected void configure() {
       install(new MyBatisModule() {
           @Override
           protected void initialize() {
               bindDataSourceProviderType(PooledDataSourceProvider.class);
               bindTransactionFactoryType(JdbcTransactionFactory.class);
                
               
               // 사용할 쿼리가 있는 MapperInterface 정의
               addMapperClass(IChatDAOMapper.class);
           }
       });
        
       bindProperties(this.binder(), createProperties());
        
       bind(SqlSession.class)
       		.annotatedWith(Names.named("chatMapper"))
           .toProvider(SqlSessionManagerProvider.class)
           .in(Scopes.SINGLETON);
       expose(SqlSession.class).annotatedWith(Names.named("chatMapper"));
   }
   
   public Properties createProperties() {
       final Properties myBatisProperties = new Properties();
        
       myBatisProperties.setProperty("mybatis.environment.id", "epms");
       myBatisProperties.setProperty("JDBC.driver", "oracle.jdbc.driver.OracleDriver");
       myBatisProperties.setProperty("JDBC.url", "jdbc:oracle:thin:@127.0.0.1:1521:XE");
       myBatisProperties.setProperty("JDBC.username", "system");
       myBatisProperties.setProperty("JDBC.password", "oracle");
       myBatisProperties.setProperty("JDBC.autoCommit", "false");
        
       return myBatisProperties;
   }
    
}
