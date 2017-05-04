package team.service;

import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
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
		String id= dao.check(vo.getId());
		if(id!=null){
			return false;
		}
		String enpwd = passwordEncoder.encode(vo.getPwd());
		vo.setPwd(enpwd);
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
}

