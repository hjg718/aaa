package team.service;

import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team.board.model.Board;
import team.board.model.BoardDAO;
import team.board.model.BoardVO;



@Service
public class BoardService {

	@Autowired
	private SqlSessionTemplate sqlST;

	//�Խ��� ù ������
	public Board boardFirstPage(int num){
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		Board b = dao.boardPage(num);
		return b;
	}
	//�Խ��� ��õ��
	public List<BoardVO> goodList(){
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		List<BoardVO> list = dao.goodList();
		return list;
	}
	//������ ��ȣ Ŭ��
	public Board boardPage(int page) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		Board b = dao.boardPage(page);
		return b;
	}
	//���� Ŭ���� �󼼳��� �����ֱ�
	public BoardVO info(int num) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		BoardVO board = dao.info(num);
		return board;
	}
	//����
	public boolean update(BoardVO board) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		int n = dao.update(board);
		boolean ok =false;
		if(n>0){
			ok = true;
		}
		return ok;
	}
	//����
	public boolean delete(int num) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
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
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		int n = dao.input(board);
		boolean ok =false;
		if(n>0){
			ok = true;
		}
		return ok;
	}
	//�˻�
	public String search(String cat, String key, int page) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		List<BoardVO> list = dao.search(cat,key, page);
		JSONArray jar = new JSONArray();
		for(int i = 0 ; i<list.size(); i++){
			JSONObject job = new JSONObject();
			job.put("num", list.get(i).getNum());
			job.put("title",list.get(i).getTitle());
			job.put("author",list.get(i).getAuthor());
			job.put("currpage",list.get(i).getCurrpage());
			job.put("totalpage",list.get(i).getTotalpage());
			job.put("readCnt",list.get(i).getReadCnt());
			job.put("goodcnt",list.get(i).getGoodcnt());
			jar.add(job);
		}		
		return jar.toJSONString();
	}
	//��ȸ��
	public void readCnt(BoardVO boardvo) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		int cnt = boardvo.getReadCnt();//��ȸ�� +1
		boardvo.setReadCnt(cnt);
		dao.readCnt(boardvo);
	}
	//��õ��, ��õ �ߺ� �Ұ�
	public boolean goodCnt(BoardVO board) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		boolean ok = false;
		boolean good = true;

		String goodId= board.getGoodname();
		int goodNum = board.getGoodnum();

		List<BoardVO> list = dao.goodUserList(board);

		//ó���� �ۿ��� ��õ������ ������ ���̵� DB���̺� �����Ƿ� if�� ����
		if(list.size() == 0){
			good=true;
		}
		else{
			for(int i = 0 ; i<list.size();i++){
				//�۹�ȣ�� ����Ʈ���� ������ �۹�ȣ�� ������
				if(goodNum == list.get(i).getGoodnum()){
					good=false;
				}
			}
		}
		if(good){
			int n = dao.goodCnt(board); //��õ�� +1 �ϱ�
			if(n>0){
				ok = true;
				dao.goodCntUser(board); // �α��ε� ���̵��, �۹�ȣ�� ����
				return ok;
			}
		}
		if(good == false){
			return ok=false;
		}
		return false;
	}
	public BoardVO recent(String id) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		BoardVO vo = dao.recent(id);
		return vo;
	}



}
