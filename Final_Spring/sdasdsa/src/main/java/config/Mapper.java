package config;

import java.lang.annotation.*;

/**
 * MyBatis Mapper Marker Annotation
 *
 * {@link org.mybatis.spring.mapper.MapperScannerConfigurer}�� ���ؼ� Mapper Bean���� ��ϵǾ���ϴ� ������� ���
 *
 * @author arawn.kr@gmail.com
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Mapper {
}