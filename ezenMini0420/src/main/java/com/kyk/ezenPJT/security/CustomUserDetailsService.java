package com.kyk.ezenPJT.security;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.kyk.ezenPJT.dao.EzenDao;
import com.kyk.ezenPJT.dto.AuthUserDto;
import com.kyk.ezenPJT.dto.EzenJoinDto;
import com.kyk.ezenPJT.util.Constant;

public class CustomUserDetailsService implements UserDetailsService {

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		EzenDao edao = Constant.edao;
		AuthUserDto adto = null;
		EzenJoinDto fdto = null;
		Boolean flag = false;
		//EzenJoinDto는 DB EZENUSER의 레코드와 매핑됨
		if(username.startsWith("kakao_") || username.startsWith("naver_") || username.startsWith("google_")) {
			adto = edao.authLogin(username);
		}
		else {
			fdto = edao.login(username);
			flag = true;
			if(fdto == null) {
				System.out.println("security에서 dto null로 로그인 실패");
				throw new UsernameNotFoundException("No user found with username");
				//스프링 시큐리티에서 예외를 처리하여 로그인실패처리
			}
		}
		
		System.out.println("fdto" + fdto);
		System.out.println("adto" + adto);
		
		if(flag) {
			String pw = fdto.getPpw();
			String auth = fdto.getPauth();
			System.out.println("pw : " + pw + " auth : " + auth);
			Collection<SimpleGrantedAuthority> roles = new ArrayList<SimpleGrantedAuthority>();
			//roles는 권한 ROLE을 저장하는 객체
			//role값(권한 구분값, ROLE_USER, ROLE_ADMIN, ROLE_MANAGE 등)을 저장하는 리스트 객체
			//ROLE_TEMPORARY_USER (임시 사용자)
			roles.add(new SimpleGrantedAuthority(auth));
			
			UserDetails user = new User(username, pw, roles);
			
			return user;
		}
		
		else {
			String pw = adto.getAuthPw();
			String auth = adto.getAuth();
			System.out.println("pw : " + pw + " auth : " + auth);
			Collection<SimpleGrantedAuthority> roles = new ArrayList<SimpleGrantedAuthority>();
			//roles는 권한 ROLE을 저장하는 객체
			//role값(권한 구분값, ROLE_USER, ROLE_ADMIN, ROLE_MANAGE 등)을 저장하는 리스트 객체
			//ROLE_TEMPORARY_USER (임시 사용자)
			roles.add(new SimpleGrantedAuthority(auth));
			
			UserDetails user = new User(username, pw, roles);
			
			return user;
		}
		
	}

}
