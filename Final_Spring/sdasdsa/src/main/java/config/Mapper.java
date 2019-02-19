package config;

import java.lang.annotation.*;

import com.google.inject.BindingAnnotation;

/**
 * MyBatis Mapper Marker Annotation
 *
 * {@link org.mybatis.spring.mapper.MapperScannerConfigurer}�� ���ؼ� Mapper Bean���� ��ϵǾ���ϴ� ������� ���
 *
 * @author arawn.kr@gmail.com
 */
@BindingAnnotation
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Mapper {
}