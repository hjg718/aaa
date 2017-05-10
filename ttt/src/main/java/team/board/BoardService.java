package team.board;

import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardService {

	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	//�Խ��� ù ������
	public Board boardFirstPage(int num){
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		Board b = dao.boardPage(num);
		return b;
	}
	//������ ��ȣ Ŭ��
	public Board boardPage(int page) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		Board b = dao.boardPage(page);
		return b;
	}
	//���� Ŭ���� �󼼳��� �����ֱ�
	public BoardVO info(int num) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		BoardVO board = dao.info(num);
		return board;
	}
	//����
	public boolean update(BoardVO board) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		int n = dao.update(board);
		boolean ok =false;
		if(n>0){
			ok = true;
		}
		return ok;
	}
	//����
	public boolean delete(int num) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		int n =dao.delete(num);
		boolean ok =false;
		if(n>0){
			ok=true;
		}
		else if(n<0){
			ok=false;
		}
		return ok;
		
	}
	//�۾���
	public boolean input(BoardVO board) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		int n = dao.input(board);
		System.out.println(n);
		boolean ok =false;
		if(n>0){
			ok = true;
		}
		return ok;
	}
	//�˻�
	public String search(String cat, String key) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		List<BoardVO> list = dao.search(cat,key);
		
		JSONArray jar = new JSONArray();
		for(int i = 0 ; i<list.size(); i++){
			
			JSONObject job = new JSONObject();
			
			job.put("num", list.get(i).getNum());
			job.put("title",list.get(i).getTitle());
			job.put("author",list.get(i).getAuthor());
			jar.add(job);
		}		
		return jar.toJSONString();
	}

	
	

}
