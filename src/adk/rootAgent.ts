import "dotenv/config";
import { LlmAgent } from "@google/adk";
import { generateVideoTool } from "@/adk/tools/generateVideoTool";

export const rootAgent = new LlmAgent({
  name: "glac_video_agent",
  model: "gemini-2.5-flash",
  description:
    "An agent that can generate Veo videos from prompts and save them as mp4 artifacts.",
  instruction:
    "You are a helpful assistant for generating short videos. " +
    "When the user asks for a video, call the generate_video tool with a detailed prompt. " +
    "After generating, tell the user the output filename.",
  tools: [generateVideoTool],
});
