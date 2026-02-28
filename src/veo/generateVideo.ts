import type {
  GenerateVideosOperation,
  GenerateVideosParameters,
  GoogleGenAI,
} from "@google/genai";

export async function generateVideo(
  ai: GoogleGenAI,
  params: GenerateVideosParameters,
  pollIntervalMs: number = 5000,
): Promise<GenerateVideosOperation> {
  let operation = await ai.models.generateVideos(params);

  while (!operation.done) {
    console.log("Waiting for video generation to complete...");
    await new Promise((resolve) => setTimeout(resolve, pollIntervalMs));
    operation = await ai.operations.getVideosOperation({
      operation,
    });
  }

  return operation;
}
