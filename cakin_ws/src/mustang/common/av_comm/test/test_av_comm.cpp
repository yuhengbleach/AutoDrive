#include <av_comm/comm.h>
#include <gtest/gtest.h>
#include <thread>
#include <chrono>

TEST(av_comm, log4ros) {
    double num = 76.999999999;
    AV_DEBUG_KV(MSG("Test."), KV(num), KV("song", "girigiri"));
    AV_INFO_KV(MSG("Test."), KV(num), KV("song", "girigiri"));
    AV_WARN_KV(MSG("Test."), KV(num), KV("song", "girigiri"));
    AV_ERROR_KV(MSG("Test."), KV(num), KV("song", "girigiri"));
    AV_FATAL_KV(MSG("Test."), KV(num), KV("song", "girigiri"));

    AV_DEBUG("msg=%s||num=%lf||song=%s", "Test.", num, "girigiri");
    AV_INFO("msg=%s||num=%lf||song=%s", "Test.", num, "girigiri");
    AV_WARN("msg=%s||num=%lf||song=%s", "Test.", num, "girigiri");
    AV_ERROR("msg=%s||num=%lf||song=%s", "Test.", num, "girigiri");
    AV_FATAL("msg=%s||num=%lf||song=%s", "Test.", num, "girigiri");
}

TEST(av_comm, Now) {
    auto pre = av_comm::Now();
    std::this_thread::sleep_for(std::chrono::milliseconds(100));
    auto now = av_comm::Now();
    auto delta = now - pre;
    EXPECT_TRUE(95 <= delta && delta <= 105);
}

int main(int argc, char** argv) {
    testing::InitGoogleTest(&argc, argv);
    ros::init(argc, argv, "av_comm_test");
    return RUN_ALL_TESTS();
}
