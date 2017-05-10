package team.service;

import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jdk.nashorn.internal.scripts.JS;
import team.QnA.QnaDao;
import team.QnA.QnaVo;

@Service
public class QnaService {
	
	@Autowired
	private SqlSessionTemplate sqlST;

	public String  save(QnaVo vo){
		QnaDao dao = sqlST.getMapper(QnaDao.class);
		JSONObject job = new JSONObject();
		int input = dao.save(vo);
		boolean ok ;
		if(input == 0){
			ok = false;
		}else {
			ok = true;
		}
		job.put("save",ok);
		return job.toJSONString();
	}
	
	public String Recent(String userId){
		QnaDao dao = sqlST.getMapper(QnaDao.class);
		JSONObject job = new JSONObject();
		QnaVo vo = dao.Recent(userId);
		job.put("recent",vo);
		return job.toJSONString();
	}
}
