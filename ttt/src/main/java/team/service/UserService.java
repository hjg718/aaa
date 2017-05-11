package team.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.sun.javafx.collections.MappingChange.Map;

import team.book.model.Book;
import team.book.model.BookVo;
import team.user.model.RentalVo;
import team.user.model.User;
import team.user.model.UserDao;
import team.user.model.UserVo;



@Service
public class UserService {

	@Autowired
	private SqlSessionTemplate sqlST;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder; 
	
	public boolean join(UserVo vo){
		UserDao dao= sqlST.getMapper(UserDao.class);
		String id= dao.check(vo.getUserid());
		if(id!=null){
			return false;
		}
		if(vo.getAuthority()==null){
			vo.setAuthority("USER");
		}
		String enpwd = passwordEncoder.encode(vo.getUpwd());
		vo.setUpwd(enpwd);
		int row = dao.join(vo);
		if(row>0){
			return true;
		}
		return false;
	}
	
	public String check(String id) {
		UserDao dao= sqlST.getMapper(UserDao.class);
		String res= dao.check(id);
		JSONObject jObj = new JSONObject();
		if(res!=null){
			jObj.put("ok", false);
		}
		else{
			jObj.put("ok", true);
		}
		return jObj.toJSONString();
	}

	public UserVo getvo(String id) {
		UserDao dao= sqlST.getMapper(UserDao.class);
		UserVo vo= dao.getvo(id);
		return vo;
	}

	public boolean edit(UserVo vo, String newpwd) {
		UserDao dao= sqlST.getMapper(UserDao.class);
		UserVo dbvo = dao.getvo(vo.getUserid());
		boolean pass = passwordEncoder.matches(vo.getUpwd(), dbvo.getUpwd());
		if(pass){
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("vo", vo);
			if(newpwd!=""){
				map.put("newpwd",passwordEncoder.encode(newpwd));
			}
			int row = dao.edit(map);
			if(row>0){
				return true;
			}
		}
		return false;
	}

	public String secession(String upwd, String userid) {
		UserDao dao= sqlST.getMapper(UserDao.class);
		UserVo dbvo = dao.getvo(userid);
		boolean pass = passwordEncoder.matches(upwd, dbvo.getUpwd());
		JSONObject jobj = new JSONObject();
		if(pass){
			int row = dao.secession(userid);
			if(row>0){
				jobj.put("pass", true);
			}else{
				jobj.put("pass", false);
			}
		}
		return jobj.toJSONString();
	}

	public User getinfo(String id) {
		UserDao dao= sqlST.getMapper(UserDao.class);
		User user = new User();
		List<RentalVo> rentalInfo = dao.rentalInfo(id);
		List<BookVo> bvoList = new ArrayList<BookVo>();
		for(int i=0;i<rentalInfo.size();i++){
			BookVo vo = dao.rentalBook(rentalInfo.get(i).getBooknum());
			bvoList.add(vo);
			Calendar cal = new GregorianCalendar(Locale.KOREA);
			cal.setTime(rentalInfo.get(i).getRentaldate());
			cal.add(Calendar.DAY_OF_YEAR, 10);
			SimpleDateFormat sd = new SimpleDateFormat("MM-dd");
			String returndate = sd.format(cal.getTime());
			rentalInfo.get(i).setReturndate(returndate);
			String rendate = sd.format(rentalInfo.get(i).getRentaldate());
			rentalInfo.get(i).setRendate(rendate);
			Date today = new Date();
			long day = cal.getTime().getTime() - today.getTime();
			long diffday = day/(24*60*60*1000);
			rentalInfo.get(i).setDay(""+diffday);
		}
		UserVo vo = getvo(id);
		user.setBvoList(bvoList);
		user.setRvoList(rentalInfo);
		user.setVo(vo);
		return user;
	}
}

