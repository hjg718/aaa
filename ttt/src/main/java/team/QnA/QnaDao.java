package team.QnA;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface QnaDao {

	public int save(QnaVo vo);
	
	public QnaVo Recent(String userId);
	
	public ArrayList<QnaVo> List();
	
	public Qna getPage(int page);
	
	public QnaVo Read(int num);
	
	public ArrayList<QnaVo> Find(@Param("keyword")String keyword , @Param("category")String category,@Param("pgnum")int pgnum);
	
	public int Modify(QnaVo vo);
	
	public int Delete(int num);
	
}
