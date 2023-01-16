package com.kyk.ezenPJT.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.AccessGrant;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.kyk.ezenPJT.command.AuthCommand;
import com.kyk.ezenPJT.command.CalendarInsertCommand;
import com.kyk.ezenPJT.command.CalendarListCommand;
import com.kyk.ezenPJT.command.CalendarUpdateCommand;
import com.kyk.ezenPJT.command.DashBoardCommand;
import com.kyk.ezenPJT.command.EzenAdminAuthCommand;
import com.kyk.ezenPJT.command.EzenBoardContentCommand;
import com.kyk.ezenPJT.command.EzenBoardDeleteCommand;
import com.kyk.ezenPJT.command.EzenBoardListCommand;
import com.kyk.ezenPJT.command.EzenBoardModifyCommand;
import com.kyk.ezenPJT.command.EzenBoardPageListCommand;
import com.kyk.ezenPJT.command.EzenBoardReplyCommand;
import com.kyk.ezenPJT.command.EzenBoardReplyViewCommand;
import com.kyk.ezenPJT.command.EzenBoardWriteCommand;
import com.kyk.ezenPJT.command.EzenCommand;
import com.kyk.ezenPJT.command.EzenJoinCommand;
import com.kyk.ezenPJT.command.EzenRecipeCommand;
import com.kyk.ezenPJT.command.EzenRecipeDetailsCommand;
import com.kyk.ezenPJT.command.EzenRecipeWriteCommand;
import com.kyk.ezenPJT.command.calendarDeleteCommand;
import com.kyk.ezenPJT.dao.EzenDao;
import com.kyk.ezenPJT.dto.AuthUserDto;
import com.kyk.ezenPJT.dto.DashBoardDto;
import com.kyk.ezenPJT.dto.EzenBoardDto;
import com.kyk.ezenPJT.dto.FullCalendarDto;
import com.kyk.ezenPJT.dto.RecipeDto;
import com.kyk.ezenPJT.naver.NaverLoginBO;
import com.kyk.ezenPJT.util.Constant;


@Controller
public class EzenController {
	
	private EzenCommand com;
	
	//암호화 처리 bean주입(공통사용요소이므로 주입 후 저장해놓고 사용)
	private BCryptPasswordEncoder passwordEncoder;
	@Autowired
	public void setPasswordEncoder(BCryptPasswordEncoder passwordEncoder) {
		this.passwordEncoder = passwordEncoder;
		Constant.passwordEncoder = passwordEncoder;
	}
	
	//EzenDao클래스 주입
	private EzenDao edao;
	@Autowired
	public void setEdao(EzenDao edao) {
		this.edao = edao;
		Constant.edao = edao;
	}
	
	//NaverLoginBO객체 주입
	private NaverLoginBO naverLoginBO;
	@Autowired
	public void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
	
	//google login Bean
	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;
	
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;
	
	@RequestMapping("/home")
	public String home() {
		System.out.println("home");
		return "home";
	}
	
	@RequestMapping("/mhome")
	public String mhome() {
		System.out.println("mhome");
		return "mhome";
	}
	
	//클라이언트에서 요청을 ajax로 실시
	//리턴으로 jsp를 보낼시는 @ResponseBody없이 보냄
	@RequestMapping("/joinView")
	public String joinView() {
		return "joinView";
	}
	
	@RequestMapping("/loginView")
	public String loginView(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) {
		System.out.println("loginView");
		socialUrl(model,session);
		return "loginView";
	}
	
	private void socialUrl(Model model, HttpSession session) {
		//kakao의 Oauth2(개방형 로그인) url구하기
		//kakao code kakao developer페이지에 가서 등록
		String kakao_url = "https://kauth.kakao.com/oauth/authorize"
							+"?client_id=bdb56a47b2161398cebac27f99924b92" //카카오 발행 인증 키값
							+"&redirect_uri=https://localhost:8443/ezenPJT/kredirect" //인증후 결과를 통보할 요청 경로
							+"&response_type=code";
		model.addAttribute("kakao_url", kakao_url);
		
		//naver의 url구하기
		//네이버아이디로 인증 URL을 생성하기 위하여 NaverLoginBO클래스의 getAuthorizationUrl메소드 호출
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		System.out.println("네이버" + naverAuthUrl);
		model.addAttribute("naver_url",naverAuthUrl);
		
		//google url구하기
		//구글code발행, OAuth2를 처리하는 객체
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		//GrantType은 Oauth2처리방식 AUTORIZATION_CODE는 서버사이트 인증, googleOAuth2Parameter는
		//빈에 설정된 scope와 redirect정보를 가진 객체
		System.out.println("구글: " + url);
		model.addAttribute("google_url", url);
	}
	
	//social login redirect
	//kakao
	@RequestMapping(value="/kredirect", produces="application/json; charset=UTF-8")
	public String kredirect(@RequestParam String code, HttpServletResponse response, Model model, HttpServletRequest request) throws Exception {
		System.out.println("#########" + code);
		String access_Token = getKakaoAccessToken(code,response);
		System.out.println("###access_Token#### : " + access_Token);
		//이 access_Token을 이용하여 kakao의 사용자 정보를 얻어냄
		HashMap<String, Object> userInfo = getKakaoUserInfo(access_Token);
		String email = (String)userInfo.get("email");
		String authUsername = "kakao_" + email;
		String authPw = (String)userInfo.get("nickname"); //암호화되기 전
		String cryptPw = passwordEncoder.encode(authPw);
		
		AuthUserDto dto = new AuthUserDto(authUsername,cryptPw,null);
		authDB(request,model,dto);
		
		model.addAttribute("authUser", authUsername);
		model.addAttribute("authPw", authPw);
		
		return "socialLogin";
	}
	
	private void authDB(HttpServletRequest request, Model model, AuthUserDto dto) {
		com = new AuthCommand();
		request.setAttribute("dto", dto);
		com.execute(request, model);
	}

	//naver
	@RequestMapping(value="/nredirect", produces="application/json; cahrset=UTF8")
	public String nredirect(@RequestParam String code, @RequestParam String state, HttpSession session, Model model, HttpServletRequest request) throws Exception {
		System.out.println("nredirect");
		System.out.println("state : " + state);
		OAuth2AccessToken oauthToken = naverLoginBO.getAccessToken(session, code, state);
		String apiResult = naverLoginBO.getUserProfile(oauthToken);
		System.out.println(apiResult);
		//String형식인 apiResult를 json형태로 저장
		JSONParser parser = new JSONParser(); //자바의 문자열을 Object객체화 하는 클래스의 객체
		Object obj = parser.parse(apiResult); //자바의 문자열을 자바의 Object
		JSONObject jsonObj = (JSONObject) obj; //자바 Object를 자식 클래스인 JSONObject로 형변환
		JSONObject responseObj = (JSONObject)jsonObj.get("response"); //apiResult의 response
		System.out.println("naver user정보 : " + responseObj);
		
		//response의 email값 반환
		String authUsername = "naver_" + (String)responseObj.get("email");
		String authPw = (String)responseObj.get("name");
		String id = (String)responseObj.get("id");
		
		System.out.println("email " + authUsername);
		System.out.println("nickname " + authPw);
		System.out.println("id " + id);
		
		String cryptPw = passwordEncoder.encode(authPw);
		
		AuthUserDto dto = new AuthUserDto(authUsername,cryptPw,null);
		authDB(request,model,dto);
		model.addAttribute("authUser", authUsername);
		model.addAttribute("authPw", authPw);
		
		return "socialLogin";
	}
	
	public String getKakaoAccessToken (String authorize_code,HttpServletResponse response)  {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8"); 
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token"; //토큰 정보를 받기 위한 요청 경로
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			// URL연결은 입출력에 사용 될 수 있고, POST 혹은 PUT 요청을 하려면 setDoOutput을 true로 설정해야함.
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			//kakao로 응답해주는 값
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=bdb56a47b2161398cebac27f99924b92");  //본인이 발급받은 key
			sb.append("&redirect_uri=https://localhost:8443/ezenPJT/kredirect");
			sb.append("&code=" + authorize_code);
			bw.write(sb.toString());
			bw.flush();
			//결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			 BufferedReader br = 
		            	new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
			 String line = "";
	         String result = "";
	         while ((line = br.readLine()) != null) {
	        	result += line;
	         }
	         System.out.println("response body : " + result);
	         JSONParser parser = new JSONParser();
	         Object obj = parser.parse(result); //parse메서드는 Object반환
	         JSONObject jsonObj = (JSONObject) obj;
	         access_Token = (String)jsonObj.get("access_token");
	         refresh_Token = (String)jsonObj.get("refresh_token");
			 System.out.println("access_token : " + access_Token);
			 System.out.println("refresh_token : " + refresh_Token);
			 br.close();
			 bw.close();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return access_Token; //kakao에서 제공해주는 이용자 정보
	}
	
	//kakao access-token에서 사용자 정보 얻기
	public HashMap<String,Object> getKakaoUserInfo (String access_Token) {
		HashMap<String, Object> userInfo = new HashMap<String, Object>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			//요청에 필요한 Header에 포함될 내용
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);
			int responseCode = conn.getResponseCode(); //200이면 정상
			System.out.println("responseCode : " + responseCode);
			BufferedReader br = 
					new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
			String line = "";
	        String result = "";
	        while ((line = br.readLine()) != null)  {
	        	 result += line;
	        }
	        
	        System.out.println("response body : " + result);
	        
	        JSONParser parser = new JSONParser();
	        Object obj = parser.parse(result);
	        JSONObject jsonObj = (JSONObject) obj;
	        String id = jsonObj.get("id").toString(); //kakao의 고유 번호(보통 시퀀스 번호)
	        JSONObject properties = (JSONObject)jsonObj.get("properties");
	        JSONObject kakao_account = (JSONObject)jsonObj.get("kakao_account"); //검수후에 가능
	        String accessToken = (String)properties.get("access_token");
	        String nickname = (String)properties.get("nickname");
	        String email = (String)kakao_account.get("email"); //검수후에 가능
	        userInfo.put("accessToken", access_Token);
            userInfo.put("nickname", nickname);
            userInfo.put("email", email);
            userInfo.put("id", id);
            System.out.println("=============");
            System.out.println("acces token  " + accessToken);
            System.out.println("nickname  " + nickname);
            System.out.println("email  " + email); 
            System.out.println("id  " + id);
		}
		catch(Exception e1) {
			e1.getMessage();
		}
		
		return userInfo;
	}
	
	//구글사용자정보 얻기 메서드
	public HashMap<String, Object> getGoogleUserInfo(String access_Token, HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		HashMap<String, Object> gUserInfo = new HashMap<String, Object>();
		String reqURL = "https://www.googleapis.com/userinfo/v2/me?access_token=" + access_Token;
		   try {
	         URL url = new URL(reqURL); 
	         HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	         conn.setRequestProperty("Authorization", "Bearer " + access_Token);
	         int responseCode = conn.getResponseCode(); 
	         System.out.println("responseCode : "+responseCode);
	         if(responseCode == 200) { //200은 연결 성공
	            BufferedReader br = 
	               new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8")); 
	            String line = ""; 
	            String result = ""; 
	            while ((line = br.readLine()) != null) {
	               result += line;
	            }
	            JSONParser parser = new JSONParser(); //문자열을 json객체화하는 객체
	            Object obj = parser.parse(result);
	            JSONObject jsonObj = (JSONObject) obj;
	            String name_obj = (String)jsonObj.get("name");
	            String email_obj = (String)jsonObj.get("email");
	            String id_obj = "GOOGLE_" + (String)jsonObj.get("id");
	            
	            gUserInfo.put("name", name_obj); 
	            gUserInfo.put("email", email_obj); 
	            gUserInfo.put("id", id_obj);
	            
	            System.out.println("gUserInfo : " + gUserInfo); 
	         }
	      }
	      catch(Exception e) {
	         e.printStackTrace();
	      }
	      
	      return gUserInfo;
	}
	
	@RequestMapping(value="/gredirect", produces="application/text; charset=UTF8")
	//구글에서 요청하는 경로
	public String googleCallback(Model model, @RequestParam String code, HttpServletResponse response, HttpServletRequest request) throws IOException {
		System.out.println("google redirect");
		//구글 code 발행, OAuth를 처리하는 객체
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		AccessGrant accessGrant = oauthOperations.exchangeForAccess(code, googleOAuth2Parameters.getRedirectUri(), null);
		String accessToken = accessGrant.getAccessToken();
		HashMap<String, Object> map = getGoogleUserInfo(accessToken, response);
		
		String email = (String)map.get("email");
		String authUsername = "google_" + email;
		String authPw = (String)map.get("name");
		String id = (String)map.get("id");
		
		System.out.println("email : " + email);
		System.out.println("name : " + authPw);
		System.out.println("id : " + id);
		
		String cryptPw = passwordEncoder.encode(authPw);
		
		AuthUserDto dto = new AuthUserDto(authUsername,cryptPw,null);
		authDB(request,model,dto);
		
		model.addAttribute("authUser", authUsername);
		model.addAttribute("authPw", authPw);
		
		return "socialLogin";
	}

	//회원가입처리 요청
	@RequestMapping(value="/join", produces="application/text; charset=UTF-8") //ajax로 요청시 한글처리
	@ResponseBody //ajax로 요청이 오고 jsp아닌 일반 문자열, 객체 map, list 등으로 반환시
	public String join(HttpServletRequest request, HttpServletResponse response, Model model) {
		System.out.println("join");
		com = new EzenJoinCommand();
		com.execute(request, model);
		String result = (String)request.getAttribute("result");
		if(result.equals("success")) {
			return "join-success";
		}
		else {
			return "join-failed";
		}
	}
	
	//로그인 성공처리, 레시피 처리
	@RequestMapping("/main")
	public String main(HttpServletRequest request, Model model, Authentication authentication) {
		System.out.println("main");
		getUsername(authentication, request);
		String username = (String)request.getAttribute("username");
		String auth = (String)request.getAttribute("auth");
		com = new EzenRecipeCommand();
		com.execute(request, model);
		return "mainView";
	}
	
	//레시피 등록창
	@RequestMapping("/rwriteView")
	public String rwriteView() {
		System.out.println("rwriteView");
		return "rwriteView";
	}
	
	//레시피 DB에 등록
	@RequestMapping("/recipeWrite")
	public String recipeWrite(MultipartHttpServletRequest mphr, Model model) {
		System.out.println("recipeWrite");
		String rClass = mphr.getParameter("rClass");
		String rtrName = mphr.getParameter("rtrName");
		String rTitle = mphr.getParameter("rTitle");
		String rContent = mphr.getParameter("rContent");
		int rId = 0; //rId는 임의로 정함(DB에서 seq넘버로 설정하니까 
		String rPhoto = null; //DB에 저장할 사진이름
		//반환되는 파일 데이터는 MultipartFile형이고 getFile(파일속성명)로 구한다
		MultipartFile mf = mphr.getFile("rPhoto");
		
		//업로드 되는 파일 저장위치 (프로젝트내, 톰캣서버내)
		//초기 신속 저장으로 바로 보여주기위해 톰캣에도 저장(war파일로 톰캣서버로 배포시는 불필요)
		String path = "D:/KYK/workspace/ezenMini0420/src/main/webapp/resources/upimage/";
		String path1 = "D:/KYK/util/apache-tomcat-9.0.63/wtpwebapps/ezenMini0420/resources/upimage/";
		//업로드된 파일 이름
		String originFileName = mf.getOriginalFilename();
		long prename = System.currentTimeMillis();
		long fileSize = mf.getSize();
		System.out.println("originFileName : " + originFileName);
		System.out.println("fileSize : " + fileSize);
		//저장하기위해 중복이 되는 것은 파일명을 피하기 위해 만드는 파일명
		String safeFile = path + prename + originFileName;
		String safeFiel1 = path1 + prename + originFileName;
		//DB에 저장할 파일 이름
		rPhoto = prename + originFileName;
		RecipeDto rdto = new RecipeDto(rId, rClass, rtrName, rTitle, rPhoto, rContent);
		mphr.setAttribute("rdto", rdto);
		com = new EzenRecipeWriteCommand();
		com.execute(mphr, model); //DB에 등록하고 성공여부 result를 반환. 받으면 model에 추가
		
		//model객체의 값을 추출하려면 asMap()메서드를 사용
		Map<String, Object> map = model.asMap();
		String res = (String)map.get("result");
		System.out.println("res : " + res);
		if(res.equals("success")) {
			try {
				mf.transferTo(new File(safeFile));
				mf.transferTo(new File(safeFiel1));
			}
			catch(Exception e) {
				e.printStackTrace();
			}
			return "redirect:main";
		}
		else {
			return "main";
		}
	}
	
	/* 레시피 상세정보 */
	@RequestMapping("/recipeDetails")
	public String recipeDetails(HttpServletRequest request, Model model) {
		System.out.println("recipeDetails입니다");
		com = new EzenRecipeDetailsCommand();
		com.execute(request, model);
		
		if(model.containsAttribute("rDetails")) {
			System.out.println("success");
			return "recipeDetailsView";
		}
		else {
			return "redirect:main";
		}
	}
	
	@RequestMapping("/processLogin")
	public ModelAndView processLogin(
			@RequestParam(value = "log", required = false) String log,
			@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout,
			HttpSession session, Model pmodel
			) {
		System.out.println("processLogin");
		ModelAndView model = new ModelAndView();
		if(log != null && log != "") {
			model.addObject("log", "before login!");
		}
		if(error != null && error != "") { //로그인 실패시에 security에서 processLogin?error=1
			model.addObject("error", "Invalid username or passoword");
		}
		if(logout != null && logout != "") { //processLogin?logout=1
			model.addObject("logout", "You've been logged out successfully.");
		}
		socialUrl(pmodel,session);
		model.setViewName("loginView");
		return model;
	}
	
	//logout
	@RequestMapping("/logoutView")
	public String logoutView() {
		System.out.println("logoutView");
		return "logoutView";
	}
	
	//관리자페이지
	@RequestMapping("/adminView")
	public String adminView() {
		System.out.println("adminView");
		return "adminView";
	}
	
	@RequestMapping("/authAdmin")
	@ResponseBody //ajax시 응답을 jsp가 아닌 것으로 반환(여기서는 문자열 반환)
	public String authAdmin(HttpServletRequest request, Model model) {
		System.out.println("authAdmin");
		com = new EzenAdminAuthCommand();
		com.execute(request, model);
		
		Map<String, Object> map = model.asMap();
		String res = (String)map.get("result");
		if(res.equals("success")) {
			return "success";
		}
		else
			return "failed";
	}
	
	//eBoard부분
	@RequestMapping("/eBoard")
	public String eBoard(HttpServletRequest request, Model model) {
		System.out.println("eBoard요청");
		com = new EzenBoardListCommand();
		com.execute(request, model);
		return "eBoardView";
	}
	
	
	@RequestMapping("/plist")
	public String purl(HttpServletRequest request, Model model) {
		System.out.println("plist요청");
		System.out.println(request.getParameter("pageNo"));
		com = new EzenBoardPageListCommand();
		com.execute(request, model);
		return "pageBoard";
	}
	
	@RequestMapping("/searchBoard")
	public String searchBoard(HttpServletRequest request, Model model) {
		System.out.println("searchBoard요청");
		
		com.execute(request, model);
		return "searchBoard";
	}
	
	@RequestMapping("/writeView")
	public String writeView() {
		System.out.println("writeView요청");
		return "writeView";
	}
	
	@RequestMapping(value="/bWrite", produces="application/text; charset=UTF-8")
	public String bWrite(HttpServletRequest request, Model model) {
		System.out.println("bWrite요청");
		com = new EzenBoardWriteCommand();
		com.execute(request, model);
		com = new EzenBoardListCommand();
		com.execute(request, model);
		return "eBoardView";
	}
	
	@RequestMapping("/contentView")
	public String contentView(HttpServletRequest request, Model model) {
		System.out.println("contentView요청");
		com = new EzenBoardContentCommand();
		com.execute(request, model);
		return "contentView";
	}
	
	@RequestMapping(value="/modify", produces="application/text; charset=UTF-8")
	public String modify(HttpServletRequest request, Model model) {
		System.out.println("modify요청");
		com = new EzenBoardModifyCommand();
		com.execute(request, model);
		com = new EzenBoardListCommand();
		com.execute(request, model);
		return "eBoardView";
	}
	
	@RequestMapping("/delete")
	public String delete(HttpServletRequest request, Model model) {
		System.out.println("delete요청");
		com = new EzenBoardDeleteCommand();
		com.execute(request, model);
		com = new EzenBoardListCommand();
		com.execute(request, model);
		return "eBoardView";
	}
	
	@RequestMapping("/replyView")
	public String replyView(HttpServletRequest request, Model model) {
		System.out.println("replyView요청");
		com = new EzenBoardReplyViewCommand();
		com.execute(request, model);
		return "replyWrite";
	}
	
	@RequestMapping(value="/reply", produces="application/text; charset=UTF-8")
	public String reply(EzenBoardDto dto, HttpServletRequest request, Model model) {
		System.out.println("reply요청");
		com = new EzenBoardReplyCommand();
		request.setAttribute("formDto", dto);
		com.execute(request, model);
		com = new EzenBoardListCommand();
		com.execute(request, model);
		return "eBoardView";
	}
	
	@RequestMapping("/util")
	public String util() {
		System.out.println("util요청");
		return "utils";
	}
	
	@RequestMapping("/fCalendar")
	public String fCalendar() {
		System.out.println("fCalendar요청");
		return "fCalendar";
	}
	
	@RequestMapping("/sse")
	public String sse() {
		System.out.println("sse요청");
		return "sseView";
	}
	
	@RequestMapping("/seventEx")
	public void seventEx(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("single event");
		response.setContentType("text/event-stream"); //event-stream이 아니면 sse안됨
		response.setCharacterEncoding("UTF-8");
		PrintWriter writer = response.getWriter();
		for(int i = 0; i < 20; i++) {
			writer.write("data: " + System.currentTimeMillis() + "/n/n");
			//보내줄 값은 System.currentTimeMillis() + "/n/n"이며
			//"data: "은 데이터라는 구분자로 event객체에 정보를 갖는 속성
			writer.flush();
			try {
				Thread.sleep(1000);
			}
			catch(Exception e) {
				e.getMessage();
			}
		}
		
		writer.close();
	}
	
	@RequestMapping(value="/calendar", produces="application/json; charset=UTF-8")
	@ResponseBody
	public ArrayList<HashMap<String,Object>> calendar(HttpServletRequest request, Model model) {
		//JS에서 ArrayList는 배열이며 HashMap<String,Object>은 Object
		System.out.println("calendar요청");
		System.out.println("cId : " + request.getParameter("cId"));
		
		com = new CalendarListCommand();
		com.execute(request, model);
		HashMap<String, Object> map = (HashMap)model.asMap();
		ArrayList<FullCalendarDto> calendarList = (ArrayList)map.get("calendarList");
		
		ArrayList<HashMap<String,Object>> clistArr = new ArrayList<HashMap<String,Object>>();
		for(FullCalendarDto dto : calendarList) {
			HashMap<String,Object> clistMap = new HashMap<String, Object>();
			String cAllDay = dto.getcAllDay();
			boolean allDay;
			if(cAllDay.equals("true")) {
				allDay = true;
			}
			else {
				allDay = false;
			}
			
			clistMap.put("cNo",dto.getcNo());
			clistMap.put("cId",dto.getcId());
			clistMap.put("title",dto.getcTitle());
			clistMap.put("start",dto.getcStart());
			clistMap.put("end",dto.getcEnd());
			clistMap.put("allDay",allDay);
			
			clistArr.add(clistMap);
		}
	
		return clistArr;
	}
	
	@RequestMapping(value="/calendarInsert", produces="application/json; charset=UTF-8")
	@ResponseBody
	public String calendarInsert(@RequestBody FullCalendarDto fullCalendarDto, HttpServletRequest request, Model model) {
		//@RequestBody는 json으로 파라메터를 받을시
		System.out.println("calendarInsert요청");
		
		String start = fullCalendarDto.getcStart();
		String end = fullCalendarDto.getcEnd();
		
		//문자열형식의 시각을 LocalDateTime형식으로 변환
		//DateTimeFormatter formatDateTime = DateTimeFormatter.ofPattern("yyyy-MM-DD'T'HH:mm");
		//LocalDateTime localDateTime = LocalDateTime.from(formatDataTime.parse(start));
		
		//위의것이 안듣는 경우(시간표시에 z가 붙은 경우)
		DateTimeFormatter ISO_DATE_TIME = DateTimeFormatter.ISO_DATE_TIME;
		LocalDateTime localDateStart = LocalDateTime.from(ISO_DATE_TIME.parse(start));
		
		//LocalDateTime을 Timestamp로 변환
		Timestamp stampStart = Timestamp.valueOf(localDateStart);
		
		LocalDateTime localDateEnd = LocalDateTime.from(ISO_DATE_TIME.parse(end));
		Timestamp stampEnd = Timestamp.valueOf(localDateEnd);
		
		System.out.println("stampStart : " + stampStart);
		System.out.println("stampEnd : " + stampEnd);
		
		//시간을 계산하기 위해서는 밀리세컨드로 된 posix형식으로 변환(1970.1.1 0시부터 경과한 밀리세컨드)
		Long posixStart = stampStart.getTime();
		Long posixEnd = stampEnd.getTime();
		
		System.out.println("posixStart : " + posixStart);
		System.out.println("posixEnd : " + posixEnd);
		
		fullCalendarDto.settStart(stampStart);
		fullCalendarDto.settEnd(stampEnd);
		
		request.setAttribute("dto", fullCalendarDto);
		
		com = new CalendarInsertCommand();
		com.execute(request, model);
		
		return "success";
	}
	
	@RequestMapping(value="/calendarUpdate", produces="application/json; charset=UTF-8")
	@ResponseBody
	public String calendarUpdate(@RequestBody FullCalendarDto fullCalendarDto, HttpServletRequest request, Model model) {
		System.out.println("calendarUpdate요청");
		System.out.println("calendarUpdateNo : " + fullCalendarDto.getcNo());
		
		request.setAttribute("dto", fullCalendarDto);
		
		com = new CalendarUpdateCommand();
		com.execute(request, model);
		return "success";
	}
	
	@RequestMapping(value="/calendarDelete", produces="application/json; charset=UTF-8")
	@ResponseBody
	public String calendarDelete(@RequestBody FullCalendarDto fullCalendarDto, HttpServletRequest request, Model model) {
		System.out.println("calendarDelete요청");
		System.out.println("calendarDeleteNo : " + fullCalendarDto.getcNo());
		
		request.setAttribute("dto", fullCalendarDto);
		
		com = new calendarDeleteCommand();
		com.execute(request, model);
		
		return "success";
	}
	
	@RequestMapping("/about")
	public String about() {
		System.out.println("about요청");
		return "about";
	}
	
	//DashBoard
	@RequestMapping("/dash")		
	public String dash() {
		return "dashBoard";
	}
		
	@RequestMapping(value= "/dashView", produces = "application/json; charset=UTF8") 
	@ResponseBody
	public JSONObject dashView(HttpServletRequest request, Model model) {
		String subcmd = request.getParameter("subcmd");
		System.out.println(subcmd);
			
		com = new DashBoardCommand();
		com.execute(request, model);
			
		JSONObject result = getDashData(request,model);
			
		return result;
	}
	
	//bar
	@RequestMapping("/bar")
	public String bar() {
		System.out.println("bar요청");
		return "bar";
	}
	
	//pie
	@RequestMapping("/pie")
	public String pie() {
		System.out.println("pie요청");
		return "pie";
	}
	
	//일반메서드
	private void getUsername(Authentication authentication, HttpServletRequest request) {
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String username = userDetails.getUsername();
		System.out.println(userDetails.getUsername()); //로그인한 아이디
		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
		String auth = authorities.toString(); //role을 얻어서 문자열로 변환
		System.out.println(auth); //[ROLE_USER]형태
		request.setAttribute("username", username);
		request.setAttribute("auth", auth);
	}
	
	private JSONObject getDashData(HttpServletRequest request, Model model) {
		
		HashMap<String,Object> dashMap = (HashMap)model.asMap();
		ArrayList<DashBoardDto> dashList = (ArrayList<DashBoardDto>)dashMap.get("dashArray");
		
		JSONArray dashArr = new JSONArray();
		
		for(DashBoardDto dto:dashList ) {
			JSONObject data = new JSONObject(); //map형식으로 된 JSON객체
			data.put("month", dto.getMonth());
			data.put("pc", dto.getPcQty());
			data.put("monitor", dto.getMonitorQty());
			
			dashArr.add(data);
		}
		
		 JSONObject result = new JSONObject(); //JSONObject이므로 map형식이므로 key/value로 값을 저장
		 result.put("datas", dashArr);
		 
		 return result;
		
	}


}
