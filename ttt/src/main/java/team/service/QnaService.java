package team.service;

import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jdk.nashorn.internal.scripts.JS;
import team.QnA.Qna;
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
	
	public QnaVo Recent(String userId){
		QnaDao dao = sqlST.getMapper(QnaDao.class);
		QnaVo vo = dao.Recent(userId);
		return vo;
	}
	
	
	public ArrayList<QnaVo> List(){
		QnaDao dao = sqlST.getMapper(QnaDao.class);
		return dao.List();
	}
	
	public String getList(int page){
		QnaDao dao = sqlST.getMapper(QnaDao.class);
		JSONArray jarr = new JSONArray();
		Qna list = dao.getPage(page);
		for(int i=0; i<list.getList().size(); i++){
			JSONObject job = new JSONObject();
			job.put("title",list.getList().get(i).getTitle());
			job.put("num",list.getList().get(i).getNum());
			job.put("author",list.getList().get(i).getAuthor());
			jarr.add(job);
		}
		return jarr.toJSONString();
	}
	
}
