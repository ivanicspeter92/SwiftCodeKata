//
//  PetersBowlingGameTests.swift
//  CodeKataSwift
//
//  Created by Peter Ivanics on 30/01/16.
//  Copyright © 2016 reslink. All rights reserved.
//

import XCTest
@testable import CodeKataSwift

class PetersBowlingGameTests: BowlingGameTests {
    var frame: PetersBowlingGame.Frame!;
    var lastFrame: PetersBowlingGame.LastFrame!;
    
    override func setUp()
    {
        self.game = PetersBowlingGame();
        self.frame = PetersBowlingGame.Frame();
        self.lastFrame = PetersBowlingGame.LastFrame();
    }
    
    /**
     Test case for preventing the player to roll more than 2 times in a frame.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    func testRollMoreThanThreeTimes()
    {
        do
        {
            try self.frame.roll(0);
            try self.frame.roll(0);
            try self.frame.roll(0);
            XCTFail("It should not be possible to roll more than two times.");
        }
        catch PetersBowlingGame.Frame.BowlingFrameException.TooManyRolls { }
        catch { }
    }
    
    /**
     Test case for preventing the player to roll more after a strike in a frame.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    func testDoNotLetPlayerRollAfterStrike()
    {
        do
        {
            try self.frame.roll(10);
            try self.frame.roll(0);
            XCTFail("It should not be possible to roll after a strike in the frame.");
        }
        catch PetersBowlingGame.Frame.BowlingFrameException.TooManyRolls {}
        catch { }
    }
    
    /**
     Tests if the frame is finished after two rolls.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    func testIsFrameFinishedAfterTwoRolls()
    {
        do
        {
            try self.frame.roll(0);
            XCTAssertEqual(self.frame.isFinished(), false);
            try self.frame.roll(0);
            XCTAssertEqual(self.frame.isFinished(), true);
            try self.frame.roll(0);
            XCTFail("It should not be possible to roll more than two times.");
        }
        catch PetersBowlingGame.Frame.BowlingFrameException.TooManyRolls
        {
            XCTAssertEqual(self.frame.isFinished(), true);
        }
        catch { }
    }
    
    /**
     Tests if the frame is finished after a strike.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    func testIsFrameFinishedAfterStrike()
    {
        do
        {
            try self.frame.roll(10);
            XCTAssertEqual(self.frame.isFinished(), true);
            try self.frame.roll(0); // should throw exception
            XCTFail("It should not be possible to roll more than two times.");  // this line should not be reached
        }
        catch PetersBowlingGame.Frame.BowlingFrameException.TooManyRolls
        { XCTAssertEqual(self.frame.isFinished(), true); }
        catch { }
    }
    
    /**
     Tests scoring a Strike in the frame. Also tests if the frame is finished before and after the Strike.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    func testIsFrameStrike()
    {
        do
        {
            XCTAssertFalse(self.frame.isFinished());
            XCTAssertFalse(self.frame.isStrike());
            XCTAssertFalse(self.frame.isSpare());
            
            try self.frame.roll(10);
            XCTAssertTrue(self.frame.isFinished());
            XCTAssertTrue(self.frame.isStrike());
            XCTAssertFalse(self.frame.isSpare());
        }
        catch
        { XCTFail("There should not be exceptions thrown in this test."); }
    }
    
    /**
     Tests scoring a Spare in the frame. Also tests if the frame is finished before and after the Strike.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    func testIsFrameSpare()
    {
        do
        {
            XCTAssertFalse(self.frame.isFinished());
            XCTAssertFalse(self.frame.isStrike());
            XCTAssertFalse(self.frame.isSpare());
            
            try self.frame.roll(3);
            XCTAssertFalse(self.frame.isFinished());
            XCTAssertFalse(self.frame.isStrike());
            XCTAssertFalse(self.frame.isSpare());
            
            try self.frame.roll(7);
            XCTAssertTrue(self.frame.isFinished());
            XCTAssertFalse(self.frame.isStrike());
            XCTAssertTrue(self.frame.isSpare());
        }
        catch
        { XCTFail("There should not be exceptions thrown in this test."); }
    }
    
    /**
     Tests calculating the frame's score. 
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    func testFrameScore()
    {
        XCTAssertNil(self.frame.score());
        
        do
        {
            try self.frame.roll(5);
            XCTAssertEqual(self.frame.score(), 5);
            XCTAssertFalse(self.frame.isFinished());
            try self.frame.roll(2);
            XCTAssertEqual(self.frame.score(), 7);
            XCTAssertTrue(self.frame.isFinished());
        }
        catch { XCTFail("There should not be exceptions thrown in this test."); }
    }
    
    // MARK: - LastFrame tests
    /**
     Tests the if last frame object finished after scoring two simple rolls (no strike or spare). Also tests the scores and spare/strike status of the frame after each roll.
    
    - Author: Peter Ivanics
    - Date: 30.01.2016.
     */
    func testLastFrameNoSpareOrStrike()
    {
        XCTAssertNil(self.lastFrame.score());
        XCTAssertFalse(self.lastFrame.isFinished());
        XCTAssertFalse(self.lastFrame.isSpare());
        XCTAssertFalse(self.lastFrame.isStrike());
        
        do
        {
            try self.lastFrame.roll(0);
            XCTAssertFalse(self.lastFrame.isFinished());
            XCTAssertFalse(self.lastFrame.isSpare());
            XCTAssertFalse(self.lastFrame.isStrike());
            XCTAssertEqual(self.lastFrame.score(), 0);
            
            try self.lastFrame.roll(5);
            XCTAssertTrue(self.lastFrame.isFinished());
            XCTAssertFalse(self.lastFrame.isSpare());
            XCTAssertFalse(self.lastFrame.isStrike());
            XCTAssertEqual(self.lastFrame.score(), 5);
        }
        catch { XCTFail("There should not be exceptions thrown in this test."); }
    }
    
    /**
     Tests the if last frame object throws TooManyRollsException if no spares or strikes were scored but the player attempts to roll for the third time.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    func testLastFrameNotAllowingMoreThanTwoRollsIfNoSpareOrStrike()
    {
        XCTAssertNil(self.lastFrame.score());
        XCTAssertFalse(self.lastFrame.isFinished());
        XCTAssertFalse(self.lastFrame.isSpare());
        XCTAssertFalse(self.lastFrame.isStrike());
        
        do
        {
            try self.lastFrame.roll(2);
            try self.lastFrame.roll(2);
            XCTAssertFalse(self.lastFrame.isSpare());
            XCTAssertFalse(self.lastFrame.isStrike());
            XCTAssertEqual(self.lastFrame.isFinished(), true);
            XCTAssertEqual(self.lastFrame.score(), 4);
            
            try self.lastFrame.roll(5); // should throw an exception
            XCTFail("Last frame should not allow 3rd attempt if the first two was not a strike or spare"); // this line should not be reached
        }
        catch PetersBowlingGame.Frame.BowlingFrameException.TooManyRolls
        { XCTAssertEqual(self.lastFrame.isFinished(), true); }
        catch { }
    }
    
    /**
     Tests calculating scores for the last attempt object with a spare in the first two rolls.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    func testLastFrameSpareAndThirdRoll()
    {
        do
        {
            XCTAssertNil(self.lastFrame.score());
            try self.lastFrame.roll(6);
            XCTAssertEqual(self.lastFrame.score(), 6);
            try self.lastFrame.roll(4);
            XCTAssertEqual(self.lastFrame.score(), 10);
            XCTAssertTrue(self.lastFrame.isSpare());
            XCTAssertFalse(self.lastFrame.isStrike());
            XCTAssertFalse(self.lastFrame.isFinished());
            
            try self.lastFrame.roll(10); // rolling 10 for the third roll
            XCTAssertEqual(self.lastFrame.score(), 20);
            XCTAssertTrue(self.lastFrame.isSpare());
            XCTAssertFalse(self.lastFrame.isStrike());
            XCTAssertTrue(self.lastFrame.isFinished());
            
            do
            {
                try self.lastFrame.roll(10); // trying to roll for the fourth time - should throw exception
                XCTFail("It should not be possible to roll 4 times on the last roll!");
            }
            catch {}
        }
        catch { XCTFail("There should not be exceptions thrown in the first three rolls during this test."); }
    }
    
    /**
     Tests calculating scores for the last attempt object with a strike in the first two rolls.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    func testLastFrameStrikeAndThirdRoll()
    {
        do
        {
            XCTAssertNil(self.lastFrame.score());
            try self.lastFrame.roll(10); // first roll
            XCTAssertEqual(self.lastFrame.score(), 10);
            XCTAssertFalse(self.lastFrame.isSpare());
            XCTAssertTrue(self.lastFrame.isStrike());
            XCTAssertFalse(self.lastFrame.isFinished());
            
            try self.lastFrame.roll(4); // second roll
            XCTAssertEqual(self.lastFrame.score(), 14);
            XCTAssertFalse(self.lastFrame.isSpare());
            XCTAssertTrue(self.lastFrame.isStrike());
            XCTAssertFalse(self.lastFrame.isFinished());
            
            try self.lastFrame.roll(10); // second roll
            XCTAssertEqual(self.lastFrame.score(), 24);
            XCTAssertFalse(self.lastFrame.isSpare());
            XCTAssertTrue(self.lastFrame.isStrike());
            XCTAssertTrue(self.lastFrame.isFinished());
            
            do
            {
                try self.lastFrame.roll(10); // trying to roll for the fourth time - should throw exception
                XCTFail("It should not be possible to roll 3 times on the last roll if the first one was !");
            }
            catch {}
        }
        catch { XCTFail("There should not be exceptions thrown in the first three rolls during this test."); }
    }
    
    /**
     Tests calculating score for the last frame with three strikes
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    func testLastFrameThreeStrikes()
    {
        do
        {
            XCTAssertNil(self.lastFrame.score());
            try self.lastFrame.roll(10); // first roll
            XCTAssertEqual(self.lastFrame.score(), 10);
            XCTAssertFalse(self.lastFrame.isSpare());
            XCTAssertTrue(self.lastFrame.isStrike());
            XCTAssertFalse(self.lastFrame.isFinished());
            
            try self.lastFrame.roll(10); // second roll
            XCTAssertEqual(self.lastFrame.score(), 20);
            XCTAssertFalse(self.lastFrame.isSpare());
            XCTAssertTrue(self.lastFrame.isStrike());
            XCTAssertFalse(self.lastFrame.isFinished());
            
            try self.lastFrame.roll(10); // second roll
            XCTAssertEqual(self.lastFrame.score(), 30);
            XCTAssertFalse(self.lastFrame.isSpare());
            XCTAssertTrue(self.lastFrame.isStrike());
            XCTAssertTrue(self.lastFrame.isFinished());
            
            do
            {
                try self.lastFrame.roll(10); // trying to roll for the fourth time - should throw exception
                XCTFail("It should not be possible to roll 3 times on the last roll if the first one was !");
            }
            catch {}
        }
        catch { XCTFail("There should not be exceptions thrown in the first three rolls during this test."); }
    }
    
    /**
     Tests calculating score for the last frame with a strike, nothing and strike again.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    func testLastFrameStikeNothingStrike()
    {
        do
        {
            XCTAssertNil(self.lastFrame.score());
            try self.lastFrame.roll(10); // first roll
            XCTAssertEqual(self.lastFrame.score(), 10);
            XCTAssertFalse(self.lastFrame.isSpare());
            XCTAssertTrue(self.lastFrame.isStrike());
            XCTAssertFalse(self.lastFrame.isFinished());
            
            try self.lastFrame.roll(0); // second roll
            XCTAssertEqual(self.lastFrame.score(), 10);
            XCTAssertFalse(self.lastFrame.isSpare());
            XCTAssertTrue(self.lastFrame.isStrike());
            XCTAssertFalse(self.lastFrame.isFinished());
            
            try self.lastFrame.roll(10); // second roll
            XCTAssertEqual(self.lastFrame.score(), 20);
            XCTAssertFalse(self.lastFrame.isSpare());
            XCTAssertTrue(self.lastFrame.isStrike());
            XCTAssertTrue(self.lastFrame.isFinished());
            
            do
            {
                try self.lastFrame.roll(10); // trying to roll for the fourth time - should throw exception
                XCTFail("It should not be possible to roll 3 times on the last roll if the first one was !");
            }
            catch {}
        }
        catch { XCTFail("There should not be exceptions thrown in the first three rolls during this test."); }
    }
}
