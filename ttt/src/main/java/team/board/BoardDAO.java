package team.board;

import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface BoardDAO {
	public Board boardPage(int pageNum); //리스트,페이지 번호
	public int input(BoardVO board); // 새 글쓰기
	public BoardVO info(int num);//제목 클릭시 내용 보여주기
	public int update(BoardVO board); //수정
	public int delete(int num); //삭제
	
	public List<BoardVO> search
	(@Param("category") String cat,@Param("keyword") String key); //검색



	
}
