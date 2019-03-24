package config;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import net.sf.log4jdbc.Log4jdbcProxyDataSource;
import net.sf.log4jdbc.tools.Log4JdbcCustomFormatter;
import net.sf.log4jdbc.tools.LoggingType;

@Configuration
@EnableTransactionManagement
@MapperScan(annotationClass=Mapper.class,basePackages="com.hb.*")
public class DBConfig {
	
	@Bean(destroyMethod="close")
	public DataSource dataSourceSpied() {
		BasicDataSource dataSource = new BasicDataSource();
		dataSource.setDriverClassName("oracle.jdbc.driver.OracleDriver");
		dataSource.setUrl("myURL");
		dataSource.setUsername("myID");
		dataSource.setPassword("myPW");
		return dataSource;
	}
	
	@Bean
	public Log4jdbcProxyDataSource dataSource(DataSource dataSourcLog) {
		Log4jdbcProxyDataSource log4jdbcProxyDataSource = new Log4jdbcProxyDataSource(dataSourcLog);
		Log4JdbcCustomFormatter formatter = new Log4JdbcCustomFormatter();
		formatter.setLoggingType(LoggingType.MULTI_LINE);
		formatter.setSqlPrefix("==== SQL => ");
		log4jdbcProxyDataSource.setLogFormatter(formatter);
		return log4jdbcProxyDataSource;
	}
	
	@Bean
	public SqlSessionFactory sqlSessionFactory(Log4jdbcProxyDataSource dataSource) throws Exception {
		SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
		factoryBean.setDataSource(dataSource);
		return factoryBean.getObject();
	}
	
	@Bean
	public PlatformTransactionManager transactionManager(Log4jdbcProxyDataSource dataSource) {
		DataSourceTransactionManager tm = new DataSourceTransactionManager();
		tm.setDataSource(dataSource);
		return tm;
	}
}
