package com.hb.account.login.kakao;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

public class KakaoLoginApi {
public static JsonNode getAccessToken(String autorize_code) {
        
        final String RequestUrl = "https://kauth.kakao.com/oauth/token";
 
        final List<NameValuePair> postParams = new ArrayList<NameValuePair>();
        
        //포스트 파라미터의 grant_type이라는 명칭에 authorization_code를 추가한다 아래도 동일
        postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));
        postParams.add(new BasicNameValuePair("client_id", "87c469147a85c30ea800cc7ebffd7165"));
        postParams.add(new BasicNameValuePair("redirect_uri", "http://118.130.22.175:8081/b/login/kakaoLogin.do")); 
        postParams.add(new BasicNameValuePair("code", autorize_code));
        
        final HttpClient client = HttpClientBuilder.create().build();
        final HttpPost post = new HttpPost(RequestUrl);
        JsonNode returnNode = null;
        
        try { 
            post.setEntity(new UrlEncodedFormEntity(postParams)); 
            final HttpResponse response = client.execute(post); 
            ObjectMapper mapper = new ObjectMapper();
            returnNode = mapper.readTree(response.getEntity().getContent()); 
        } catch (UnsupportedEncodingException e) { 
            e.printStackTrace(); 
        } catch (ClientProtocolException e) { 
            e.printStackTrace(); 
        } catch (IOException e) { 
            e.printStackTrace(); 
        } 
 
        return returnNode;
    }
}
