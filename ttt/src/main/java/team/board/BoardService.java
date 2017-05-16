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
	//�Խ��� ��õ��
	public List<BoardVO> goodList(){
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		List<BoardVO> list = dao.goodList();
		
/*		for(int i = 0 ;i<list.size() ; i++){
			list.get(i).getNum();
			System.out.println("num:"+list.get(i).getNum());
			list.get(i).getTitle();
			System.out.println("title"+list.get(i).getTitle());
			list.get(i).getAuthor();
			System.out.println("author:"+list.get(i).getAuthor());
		}*/
		return list;
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
	//��ȸ��
	public void readCnt(BoardVO boardvo) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		int cnt = boardvo.getReadCnt();
		boardvo.setReadCnt(cnt);
		dao.readCnt(boardvo);
	}
	//��õ��, ��õ �ߺ� �Ұ�
	public boolean goodCnt(BoardVO board) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		boolean ok = false;
		boolean good = true;

		String goodId= board.getGoodname();
		int goodNum = board.getGoodnum();
		System.out.println("��õ�� ���̵� goodname�� ����: "+goodId+","+"��õ�� �� ��ȣ goodnum�� ����: "+goodNum);

		List<BoardVO> list = dao.goodUserList(board);

		if(list.size() == 0){
			good=true;
		}
		else{
			for(int i = 0 ; i<list.size();i++){
				System.out.println("���̵� :"+list.get(i).getGoodname());
				System.out.println("�۹�ȣ :"+list.get(i).getGoodnum());
				//�۹�ȣ�� ����Ʈ���� ������ �۹�ȣ�� ������
				if(goodNum == list.get(i).getGoodnum()){
					System.out.println("goodNum if:"+goodNum+"����Ʈnum"+list.get(i).getGoodnum());
					System.out.println("for-if(good) : "+good);
					good=false;
				}
			}
		}//else
		System.out.println("��õ�����:"+good);
		if(good){
			System.out.println("if(good) : "+good);
			int n = dao.goodCnt(board); //��õ��
			if(n>0){
				ok = true;
				dao.goodCntUser(board);		// �α��ε� ���̵��, �۹�ȣ�� ����
				return ok;
			}
		}
		if(good == false){
			return ok=false;
		}
		return false;
	}



}
