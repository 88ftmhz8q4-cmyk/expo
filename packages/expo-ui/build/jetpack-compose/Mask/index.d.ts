import { ReactNode } from 'react';
import { ContentAlignment, PrimitiveBaseProps } from '../layout-types';
export type MaskProps = {
    children?: ReactNode;
    /**
     * Alignment of the mask content within the masked view's bounds.
     * @default 'center'
     */
    alignment?: ContentAlignment;
} & PrimitiveBaseProps;
declare function MaskContent(props: {
    children: ReactNode;
}): import("react").JSX.Element;
export declare function Mask(props: MaskProps): import("react").JSX.Element;
export declare namespace Mask {
    var Content: typeof MaskContent;
}
export {};
//# sourceMappingURL=index.d.ts.map