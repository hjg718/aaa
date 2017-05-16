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

	//게시판 첫 페이지
	public Board boardFirstPage(int num){
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		Board b = dao.boardPage(num);
		return b;
	}
	//게시판 추천수
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
	//페이지 번호 클릭
	public Board boardPage(int page) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		Board b = dao.boardPage(page);
		return b;
	}
	//제목 클릭시 상세내용 보여주기
	public BoardVO info(int num) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		BoardVO board = dao.info(num);
		return board;
	}
	//수정
	public boolean update(BoardVO board) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		int n = dao.update(board);
		boolean ok =false;
		if(n>0){
			ok = true;
		}
		return ok;
	}
	//삭제
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
	//글쓰기
	public boolean input(BoardVO board) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		int n = dao.input(board);
		boolean ok =false;
		if(n>0){
			ok = true;
		}
		return ok;
	}
	//검색
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
	//조회수
	public void readCnt(BoardVO boardvo) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		int cnt = boardvo.getReadCnt();
		boardvo.setReadCnt(cnt);
		dao.readCnt(boardvo);
	}
	//추천수, 추천 중복 불가
	public boolean goodCnt(BoardVO board) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		boolean ok = false;
		boolean good = true;

		String goodId= board.getGoodname();
		int goodNum = board.getGoodnum();
		System.out.println("추천한 아이디 goodname에 저장: "+goodId+","+"추천한 글 번호 goodnum에 저장: "+goodNum);

		List<BoardVO> list = dao.goodUserList(board);

		if(list.size() == 0){
			good=true;
		}
		else{
			for(int i = 0 ; i<list.size();i++){
				System.out.println("아이디 :"+list.get(i).getGoodname());
				System.out.println("글번호 :"+list.get(i).getGoodnum());
				//글번호와 리스트에서 가져온 글번호가 같으면
				if(goodNum == list.get(i).getGoodnum()){
					System.out.println("goodNum if:"+goodNum+"리시트num"+list.get(i).getGoodnum());
					System.out.println("for-if(good) : "+good);
					good=false;
				}
			}
		}//else
		System.out.println("추천결과값:"+good);
		if(good){
			System.out.println("if(good) : "+good);
			int n = dao.goodCnt(board); //추천수
			if(n>0){
				ok = true;
				dao.goodCntUser(board);		// 로그인된 아이디와, 글번호를 저장
				return ok;
			}
		}
		if(good == false){
			return ok=false;
		}
		return false;
	}



}
