export type Config = {
  /**
   * The environment for observability events
   *
   * @default process.env.NODE_ENV
   */
  environment?: string;
  /**
   * Whether to enable dispatching events to the server
   *
   * When `false`, any pending metrics
   * are marked as sent without being dispatched and no further metrics are dispatched
   * until this is set back to `true`.
   *
   * @default true
   */
  dispatchingEnabled?: boolean;
  /**
   * Whether to dispatch metrics that were collected in debug/development contexts
   *
   * When `false` those metrics are marked as sent without being dispatched
   * When `true`, debug/dev metrics are dispatched alongside production metrics.
   *
   * When `dispatchingEnabled` is set to `false`, then no metrics will be dispatched.
   *
   * @default false
   */
  dispatchInDebug?: boolean;
};

export interface ExpoObserveModuleType {
  dispatchEvents(): Promise<void>;
  /**
   * Configures observability settings.
   */
  configure(config: Config): void;
}
