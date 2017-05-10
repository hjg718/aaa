package team.QnA;


public interface QnaDao {

	public int save(QnaVo vo);
	
	public QnaVo Recent(String userId);
}
